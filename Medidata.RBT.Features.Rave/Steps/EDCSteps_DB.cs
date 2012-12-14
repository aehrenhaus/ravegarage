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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;


namespace Medidata.RBT.Features.Rave
{
	public partial class EDCSteps
    {

        /// <summary>
        /// sets the database to "offline", so nobody can access it
        /// </summary>
        [StepDefinition(@"I set the database to offline")]
        public void ISetTheDatabaseToOffline()
        {
            DbHelper.SetDatabaseToOffline();
        }

        /// <summary>
        /// sets the database to "online", so it is available
        /// </summary>
        [StepDefinition(@"I set the database to online")]
        public void ISetTheDatabaseToOnline()
        {
            DbHelper.SetDatabaseToOnline();
        }




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

        /// <summary>
        /// Compares the passed EDC value with the value of the corresponding column in the table ReportingRecords
        /// </summary>
        /// <param name="columnName"></param>
        /// <param name="value"></param>
        [StepDefinition(@"column ""([^""]*)"" in Reporting Records propagates to ""([^""]*)""")]
        public void IVerifyReportingRecordsColumnPropagates____To____(string columnName, string value)
        {
            Uri tempUri = new Uri(Browser.Url);
            var sql = String.Format(@"select {0} from ReportingRecords where DataPageID = {1}", columnName, int.Parse(tempUri.Query.Replace("?DP=", "")));
            var dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];
            Assert.IsTrue(dataTable.Rows[0][0].ToString() == value.ToString(), "Data doesn't propagate into Reporting Records correctly");
        }

        /// <summary>
        /// Verify the log message for query not opening event for a specific Project and Site
        /// </summary>
        /// <param name="projectName">The project to verify</param>
        /// <param name="siteName">The site to verify</param>
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
            var projectUniqueName = TestContext.GetExistingFeatureObjectOrMakeNew(project, () => new Project(project)).UniqueName;
            var sql = ClinicalViewsScripts.GenerateSQLForNumberOfRecordsThatNeedCVRefresh(projectUniqueName);
			System.Data.DataTable dataTable;
			do
			{
				System.Threading.Thread.Sleep(1000); //wait a second
				dataTable = DbHelper.ExecuteDataSet(sql).Tables[0]; //run backend query to count records needing cv refresh.
			}
			while (((int)dataTable.Rows[0][0] != 0));

		}

        /// <summary>
        /// Wait for lab update queue to be processed
        /// </summary>
        [StepDefinition(@"I wait for lab update queue to be processed")]
        public void IWaitForLabUpdateQueueToBeProcessed()
        {
            var sql = ClinicalViewsScripts.GenerateSQLForNumberOfRecordsInLabUpdateQueue();
            System.Data.DataTable dataTable;
            do
            {
                System.Threading.Thread.Sleep(1000); //wait a second
                dataTable = DbHelper.ExecuteDataSet(sql).Tables[0]; //run backend query to count records in lab update queue
            }
            while (((int)dataTable.Rows[0][0] != 0));

        }


        /// <summary>
        /// Wait for CV refresh to finish
        /// </summary>
        /// <param name="status">The status of the field</param>
        /// <param name="fieldOid">The fieldOid of the field</param>
        [StepDefinition(@"I verify ""([^""]*)"" status for field ""([^""]*)"" has been propaged on logline")]
        public void IVerify__StatusForField__HasBeenPropaged(string status, string fieldOid)
        {
            Uri tempUri = new Uri(Browser.Url);
            int dataPageId = int.Parse(tempUri.Query.Replace("?DP=", ""));
            var sql = CheckDataPointStatusPropagate(dataPageId, fieldOid, status);
            var isPropagated = DbHelper.ExecuteScalar(sql, System.Data.CommandType.Text);
            Assert.IsTrue((int)isPropagated == 1, "Propagation did not occured");
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

        private string CheckDataPointStatusPropagate(int datapageID, string fieldOID, string status)
        {
            return String.Format(@"     declare @status varchar(200)
                                        declare @numberOfStatuses int
                                        declare @numberOfRows int

                                        set @status = '{2}'

                                        select @numberOfRows = COUNT(recordid)
                                        from records
                                        where DataPageID = {0}

                                        select  @numberOfStatuses = COUNT(datapointid)
                                        from DataPoints d
                                            join records r on r.recordid = d.recordid
                                            join Fields f on f.fieldid = d.fieldid
                                        where 
                                            r.recordid in (	Select recordid 
                                                        from Records 
                                                        where DataPageID = {0}
                                                        ) 
                                            and f.OID = '{1}'
                                            and	(case 
			                                        when @status = 'isfrozen' then d.isfrozen
			                                        end
		                                        ) = 1

                                        if @numberOfStatuses = @numberOfRows
	                                        select 1 
                                        else
	                                        select 0
                                    ", datapageID, fieldOID, status);

        }

        /// <summary>
        /// Scripts pertaining to clinical views
        /// </summary>
		public class ClinicalViewsScripts
		{
            /// <summary>
            /// Generate SQL for number of records in lab update queue
            /// </summary>
            /// <returns>The number of records in the lab update queue</returns>
            public static string GenerateSQLForNumberOfRecordsInLabUpdateQueue()
            {
                return CountOfRecordsInLabUpdateQueue();
            }

            private static string CountOfRecordsInLabUpdateQueue()
			{
				return "select count(labUpdateQueueID) from labUpdateQueue";
            }
            
            /// <summary>
            /// Generate SQL for number of records that need CV refreshing
            /// </summary>
            /// <param name="projectName">The name of the project to check the Clinical Views that need refreshing</param>
            /// <returns>The number of records that need CV refreshing</returns>
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
