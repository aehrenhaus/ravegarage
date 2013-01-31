using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class ProjectCoderRegistration : 
		BaseRaveSeedableObject
	{
		public int ProjectCoderRegistrationID { get; private set; }
		public int ProjectID { get; private set; }
		public int CodingDictionaryID { get; set; }
		public DateTime Created { get; private set; }
		public DateTime Updated { get; private set; }
		public string ProjectName { get; private set; }
		public string CodingDictionaryName { get; private set; }
		public string CoderWorkFlowName { get; private set; }

		public ProjectCoderRegistrationWorkFlow ProjectCoderRegistrationWorkFlow { get; private set; }


		public ProjectCoderRegistration(string projectName, string codingDictionaryName)
			: this(projectName, codingDictionaryName, "DEFAULT")
		{ }
		private ProjectCoderRegistration(string projectName, string codingDictionaryName, string coderWorkFlowName)
		{
			this.ProjectName = projectName;
			this.CodingDictionaryName = codingDictionaryName;
			this.CoderWorkFlowName = coderWorkFlowName;
		}


		/// <summary>
		/// Helper method that creates a unique name for ProjectCoderRegistration seeded object.
		/// This object does not have a name in the db but we still need to seed this and potentially refer
		/// to it later so this method can be used to retrieve an existing seeded instance of ProjectCoderRegistration
		/// from the SeedingContext
		/// </summary>
		/// <param name="projectName">Seeded Project UniqueName</param>
		/// <param name="codingDictionaryName">Seeded CodingDictionary UniqueName</param>
		/// <returns>ProjectCoderRegistration UniqueName</returns>
		public static string CreateUniqueName(string projectName, string codingDictionaryName) { return projectName + codingDictionaryName; }

		protected override void MakeUnique()
		{
			this.UniqueName = CreateUniqueName(this.ProjectName, this.CodingDictionaryName);
		}
		protected override void SeedFromUI()
		{
			throw new NotSupportedException("Is not currently possible to create Coding Dictionaries from Rave UI");
		}
		protected override void SeedFromBackend()
		{
			this.MakeUnique();
			this.CreateObject();
		}
		protected override void CreateObject()
		{
			this.CreateProjectCoderRegistration();

			var cwf = this.FetchOrCreateDefaultWorkFlow();
			this.FetchOrCreateDefaultWorkFlowData(cwf, "IsApprovalRequired", "False");
			this.FetchOrCreateDefaultWorkFlowData(cwf, "IsAutoApproval", "True");

			this.CreateProjectCoderRegistrationWorkFlow(cwf);
		}

		private void CreateProjectCoderRegistration()
		{
			string sql = string.Format(ProjectCoderRegistration.CREATE_PROJECT_CODER_REGISTRATION_SQL,
				this.ProjectName,
				this.CodingDictionaryName);

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();
			this.ProjectCoderRegistrationID = (int)row["ProjectCoderRegistrationID"];
			this.ProjectID = (int)row["ProjectID"];
			this.CodingDictionaryID = (int)row["CodingDictionaryID"];
			this.Created = (DateTime)row["Created"];
			this.Updated = (DateTime)row["Updated"];
		}
		private void CreateProjectCoderRegistrationWorkFlow(CoderWorkFlow coderWorkFlow)
		{
			string sql = string.Format(ProjectCoderRegistration.CREATE_PROJECT_CODER_REGISTRATION_WORK_FLOW_SQL,
				this.ProjectCoderRegistrationID,
				coderWorkFlow.ID);

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();

			var projectCoderRegistrationWorkFlow = new ProjectCoderRegistrationWorkFlow()
			{
				ProjectCoderRegistrationWorkFlowID = (int)row["ProjectCoderRegistrationWorkFlowID"],
				ProjectCoderRegistrationID = (int)row["ProjectCoderRegistrationID"],
				WorkFlowID = (int)row["WorkFlowID"],
				DefaultWorkFlow = (bool)row["DefaultWorkFlow"],
				Created = (DateTime)row["Created"],
				Updated = (DateTime)row["Updated"],
				CoderWorkFlow = coderWorkFlow
			};

			this.ProjectCoderRegistrationWorkFlow = projectCoderRegistrationWorkFlow;
		}
		private CoderWorkFlow FetchOrCreateDefaultWorkFlow()
		{
			string sql = string.Format(ProjectCoderRegistration.FETCH_OR_CREATE_DEFAULT_WORK_FLOW_SQL,
				this.CoderWorkFlowName);

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();

			var cwf = new CoderWorkFlow()
			{
				ID = (int)row["ID"],
				Name = (string)row["Name"],
				Created = (DateTime)row["Created"],
				Updated = (DateTime)row["Updated"],
				DefaultWorkFlow = (bool)row["DefaultWorkFlow"],
				ExternalID = (int)row["ExternalID"]
			};

			return cwf;
		}
		private void FetchOrCreateDefaultWorkFlowData(CoderWorkFlow coderWorkFlow, string key, string value)
		{
			string sql = string.Format(ProjectCoderRegistration.FETCH_OR_CREATE_DEFAULT_WORK_FLOW_DATA_SQL,
				coderWorkFlow.ID,
				key,
				value);

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();

			var coderWorkFlowData = new CoderWorkFlowData()
			{
				ID = (int)row["ID"],
				WorkFlowKey = (string)row["WorkFlowKey"],
				WorkFlowDefaultValue = (string)row["WorkFlowDefaultValue"],
				Created = (DateTime)row["Created"],
				Updated = (DateTime)row["Updated"],
				WorkFlowID = (int)row["WorkFlowID"]
			};
			coderWorkFlow.CoderWorkFlowData.Add(coderWorkFlowData);
		}

		#region SQL STRINGS
		#region CREATE_PROJECT_CODER_REGISTRATION_SQL
		private const string CREATE_PROJECT_CODER_REGISTRATION_SQL =
			@"declare @projectName nvarchar(2000);
			declare @codingDictionaryName nvarchar(50);

			declare @projectId int;
			declare @codingDictionaryId int;

			set @projectName = '{0}';
			set @codingDictionaryName = '{1}';
			select @projectId = p.ProjectID from Projects p 
				where dbo.fnLDS(p.ProjectName, 'eng') = @projectName;
			select @codingDictionaryId = cd.CodingDictionaryID from CodingDictionaries CD 
				where CD.DictionaryName = @codingDictionaryName;

			declare @ProjectCoderRegistrationInsertedTable table
			(
				ProjectCoderRegistrationID int
			);
			insert into ProjectCoderRegistration 
			output inserted.ProjectCoderRegistrationID into @ProjectCoderRegistrationInsertedTable
			values (@projectId, @codingDictionaryId, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)


			select pcr.* from ProjectCoderRegistration pcr
			inner join @ProjectCoderRegistrationInsertedTable x on x.ProjectCoderRegistrationID = pcr.ProjectCoderRegistrationID";
		#endregion

		#region CREATE_PROJECT_CODER_REGISTRATION_WORK_FLOW_SQL
		private const string CREATE_PROJECT_CODER_REGISTRATION_WORK_FLOW_SQL =
			@"declare @projectCoderRegistrationID int;
			declare @coderWorkFlowID int;
			declare @date datetime;

			set @date = CURRENT_TIMESTAMP;
			set @projectCoderRegistrationID = {0};
			set @coderWorkFlowID = {1};

			declare @ProjectCoderRegistrationWorkFlowInsertedTable table
			(
				ProjectCoderRegistrationWorkFlowID int
			);
			insert into ProjectCoderRegistrationWorkFlow 
			output inserted.ProjectCoderRegistrationWorkFlowID into @ProjectCoderRegistrationWorkFlowInsertedTable
			values (@projectCoderRegistrationID, @coderWorkFlowID, 1, @date, @date)

			select pcrwf.* from ProjectCoderRegistrationWorkFlow pcrwf
			inner join @ProjectCoderRegistrationWorkFlowInsertedTable x on x.ProjectCoderRegistrationWorkFlowID = pcrwf.ProjectCoderRegistrationWorkFlowID";
		#endregion

		#region FETCH_OR_CREATE_DEFAULT_WORK_FLOW_SQL
		private const string FETCH_OR_CREATE_DEFAULT_WORK_FLOW_SQL =
			@"declare @coderWorkFlowName nvarchar(255);
			declare @date datetime;

			set @date = CURRENT_TIMESTAMP;
			set @coderWorkFlowName = '{0}';

			if(exists(select null from CoderWorkFlows cwf where cwf.Name = @coderWorkFlowName))
			begin
				select * from CoderWorkFlows cwf where cwf.Name = @coderWorkFlowName
			end
			else
			begin

				declare @CoderWorkflowInsertedTable table
				(
					CoderWorkFlowID int
				);
				insert into CoderWorkFlows 
				output inserted.ID into @CoderWorkflowInsertedTable
				values (@coderWorkFlowName, @date, @date, 1, 0)

				select cwf.* from CoderWorkFlows cwf
				inner join @CoderWorkflowInsertedTable x on x.CoderWorkFlowID = cwf.ID
			end";
		#endregion

		#region FETCH_OR_CREATE_DEFAULT_WORK_FLOW_DATA_SQL
		private const string FETCH_OR_CREATE_DEFAULT_WORK_FLOW_DATA_SQL =
			@"declare @workFlowId int;
			declare @coderWorkFlowDataKey nvarchar(255);
			declare @coderWorkFlowDataValue nvarchar(255);
			declare @date datetime;

			set @date = CURRENT_TIMESTAMP;
			set @coderWorkFlowDataKey = '{1}';
			set @coderWorkFlowDataValue = '{2}';
			set @workFlowId = {0};

			if(exists(select null from CoderWorkFlowData d 
				where d.WorkFlowKey = @coderWorkFlowDataKey
				and d.WorkFlowId = @workFlowId))
			begin
				select * from CoderWorkFlowData d 
					where d.WorkFlowKey = @coderWorkFlowDataKey
					and d.WorkFlowId = @workFlowId
			end
			else
			begin

				declare @CoderWorkflowDataInsertedTable table
				(
					ID int
				);
				insert into CoderWorkFlowData
				output inserted.ID into @CoderWorkflowDataInsertedTable
				values (@workFlowId, @coderWorkFlowDataKey, @coderWorkFlowDataValue, @date, @date)

				select d.* from CoderWorkFlowData d
				inner join @CoderWorkflowDataInsertedTable x on x.ID = d.ID
			end";
		#endregion
		#endregion
	}
}
