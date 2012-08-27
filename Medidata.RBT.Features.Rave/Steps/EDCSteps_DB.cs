using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;
using TechTalk.SpecFlow.Assist;


namespace Medidata.RBT.Features.Rave
{
	public partial class EDCSteps
    {
		/// <summary>
		/// Based on the column name, we call an appropriate method and assert true/false whether or not column in table datapoints propagates
		/// </summary>
		/// <param name="columnName"></param>
		[StepDefinition(@"""([^""]*)"" propagates correctly")]
		public void IVerifyDatapointColumnPropagates____(string columnName)
		{
			Uri tempUri = new Uri(Browser.Url);
			var sql = GenerateSQLQueryForColumnName(columnName, int.Parse(tempUri.Query.Replace("?DP=", "")));

			var dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];
			Assert.IsTrue((int)dataTable.Rows[0][0] == 0, "Data doesn't propagate correctly");
		}

		[When(@"I verify the log message for query not opening event for Project ""([^""]*)"" and Site ""([^""]*)""")]
		public void WhenIVerifyTheLogMessagesForQueryNotOpeningEventsForProjectEditCheckStudy3AndSiteEditCheckSite3(string projectName, string siteName)
		{
			var sql = "spVerifyQueryLog";
			var dataTable = DbHelper.ExecuteDataSet(sql, new object[] { projectName, siteName }).Tables[0];

			//SaveDataTable(dataTable);
			//TestContext.SetContextValue(LastSqlResultTable, dataTable);
			throw new NotImplementedException();
		}


		/// <summary>
		/// Wait for CV refresh to finish
		/// </summary>
		/// <param name="project"></param>
		[StepDefinition(@"I wait for Clinical View refresh to complete for project ""([^""]*)""")]
		public void IWaitForClinicalViewRefreshToCompleteForProject____(string project)
		{
			var sql = ClinicalViewsScripts.GenerateSQLForNumberOfRecordsThatNeedCVRefresh(project);
			System.Data.DataTable dataTable;
			do
			{
				System.Threading.Thread.Sleep(1000); //wait a second
				dataTable = DbHelper.ExecuteDataSet(sql).Tables[0]; //run backend query to count records needing cv refresh.
			}
			while (((int)dataTable.Rows[0][0] != 0));

		}


		private string GenerateSQLQueryForColumnName(string column, int datapageID)
		{
			if (column.Equals("AltCodedValue"))
				return AltCodedValuePropagateForDatapageIDScript(datapageID);
			else
				throw new NotImplementedException("Propagation verificaiton for " + column + " not implemented");

		}

		private string AltCodedValuePropagateForDatapageIDScript(int datapageID)
		{
			return String.Format(@"  select count(*)
                                                    from records r
                                                        join datapoints d
		                                                    on d.recordID = r.recordID
			                                                    and r.recordPosition = 0
			                                                    and d.deleted <> 1
                                                        join fields fi
		                                                    on fi.fieldID = d.fieldID
			                                                    and controlType = 'Dynamic SearchList'
	  
	                                                    join records rL
		                                                    on rL.datapageID = r.datapageID
			                                                    and rL.recordPosition > 0
	                                                    join datapoints dL
		                                                    on dL.recordID = rL.recordID
			                                                    and dL.fieldID = d.fieldID
			                                                    and dL.AltCodedValue <> d.AltCodedValue	
                                                                and dL.deleted <> 1
                                                    where r.datapageID = {0} 
                                    ", datapageID);


		}


		public class ClinicalViewsScripts
		{
			public static string GenerateSQLForNumberOfRecordsThatNeedCVRefresh(string projectName)
			{
				return CountOfRecordsRequiringCVRefreshForProject(projectName);
			}
			private static string CountOfRecordsRequiringCVRefreshForProject(string project)
			{
				return String.Format(@"     select count(r.recordID)
                                        from projects p
	                                        join studies st
		                                        on st.projectID = p.projectID
	                                        join studySites ss
		                                        on ss.studyID = st.studyID
	                                        join subjects s
		                                        on s.studySiteID = ss.studySiteID
	                                        join records r 
		                                        on r.subjectID = s.subjectID
			                                        and r.needsCVRefresh <> 0
                                        where 1 = 1
		                                        and p.projectActive = 1
		                                        and st.studyActive = 1
		                                        and r.deleted <> 1
		                                        and dbo.fnlocaldefault(projectName) = '{0}'
                                    ", project);


			}
		}
	}
}
