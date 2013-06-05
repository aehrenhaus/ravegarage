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
        /// Verify if Architect audits exist in the database.
        /// </summary>
        /// <param name="username">user, for whom audits exist</param>    
        /// <param name="projectName">project name</param>
        /// <param name="draftName">draft name</param>
        /// <param name="table">audits to find</param>
        [StepDefinition(@"I verify the following Architect audits exist for user ""([^""]*)"", project ""([^""]*)"", draft ""([^""]*)""")]
        public void IVerify__Architect__Audit__Exists(string username, string projectName, string draftName, Table table)
        {
            var user = SeedingContext.GetExistingFeatureObjectOrMakeNew(username, () => new User(username));
            var project = SeedingContext.GetExistingFeatureObjectOrMakeNew(projectName, () => new Project(projectName));


            var audits = table.CreateSet<AuditModel>();
            string sql;
            bool auditFound = false;
            System.Data.DataTable dataTable;

            foreach (AuditModel audit in audits)
            {
                sql = DBScripts.GenerateArchitectAudits(audit.Audit, user.UniqueName, project.UniqueName, 
                                                                draftName, audit.AuditSubCategory, audit.Property);
                dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];
                if (dataTable.Rows.Count > 0)
                    auditFound = true;
                else
                {
                    auditFound = false;
                    return;
                }                    
            }
            Assert.IsTrue(auditFound, "Audit not Found.");
        }

        /// <summary>
        /// Bulk signatures are applied successfully (nothing in the bulk status update queue)
        /// </summary>
        [StepDefinition(@"I wait for signature to be applied")]
        public void IWaitForSignatureToBeApplied()
        {
            var sql = DBScripts.GenerateSQLForBulkSignaturesThatAreCurrentlyProcessed();
            System.Data.DataTable dataTable;
            int timeout = 30; //timeout if bulk signature does not finish in 30 seconds
            do
            {
                System.Threading.Thread.Sleep(1000); //wait a second
                dataTable = DbHelper.ExecuteDataSet(sql).Tables[0]; //run backend query to count records in queue
                timeout--;
            }
            while (((int)dataTable.Rows[0][0] != 0) && timeout > 0);

            if (timeout <= 0)
                throw new TimeoutException("Bulk signature did not finish in timeout duration");
        }

        /// <summary>
        /// Delete all Architect audits in the database.
        /// </summary>
        /// <param name="username">user, for whom audits exist</param>
        [StepDefinition(@"I delete Architect Audits for user ""([^""]*)""")]
        public void IDelete__Architect__Audits(string username)
        {
            var user = SeedingContext.GetExistingFeatureObjectOrMakeNew(username, () => new User(username));
            DbHelper.ExecuteScalar(DBScripts.GenerateDeleteAllArchitectAudits(user.UniqueName), System.Data.CommandType.Text);
        }

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
        /// Set current subject to disabled indefinitely, due to signature being applied 
        /// </summary>
        [StepDefinition(@"I set subject to disable controls")]
        public void ISetSubjectToDisableControls____()
        {
            Uri tempUri = new Uri(Browser.Url);
            string query = tempUri.Query;
            query = query.Replace("?STUDY_GRID=", "");
            query = query.Substring(query.IndexOf("ID="));

            var sql = GenerateSQLToDisableSubjectByModifyingSproc(int.Parse(query.Replace("ID=", "")));
            var dataTable = DbHelper.ExecuteDataSet(sql);
        }


        /// <summary>
        /// All subjects will be displayed enabled/disabled as usual
        /// </summary>
        [StepDefinition(@"I set subject to enable controls")]
        public void ISetSubjectToEnableControls____()
        {
            var sql = GenerateSQLToEnableSubjectByModifyingSproc();

            var dataTable = DbHelper.ExecuteDataSet(sql);
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
        [StepDefinition(@"I verify the log message for query not opening event for Project ""([^""]*)"" and Site ""([^""]*)""")]
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
            var projectUniqueName = SeedingContext.GetExistingFeatureObjectOrMakeNew(project, () => new Project(project)).UniqueName;
            var sql = DBScripts.GenerateSQLForNumberOfRecordsThatNeedCVRefresh(projectUniqueName);
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
            var sql = DBScripts.GenerateSQLForNumberOfRecordsInLabUpdateQueue();
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

        /// <summary>
        /// Clinical Views exist for a particular project
        /// </summary>
        /// <param name="project"></param>
        public static bool ClinicalViewsExistForProject(string project)
        {
            var projectUniqueName = SeedingContext.GetExistingFeatureObjectOrMakeNew(project, () => new Project(project)).UniqueName;
            var sql = DBScripts.GenerateSQLForNumberOfCVProjects(projectUniqueName);
            System.Data.DataTable dataTable;

            dataTable = DbHelper.ExecuteDataSet(sql).Tables[0]; // run backend query to check whether clinical views project exists
            if ((int)dataTable.Rows[0][0] > 0)
                return true;
            return false;
        }

        private string GenerateSQLToDisableSubjectByModifyingSproc(int subjectID)
        {
            return String.Format(@" 
                                        alter proc spBulkStatusUpdateIsSubjectAvailable @SubjectID int
                                        as
	                                        if exists(select null from BulkStatusUpdateQueue where subjectID = @subjectID) OR ({0} = @subjectID)
		                                        select cast(0 as bit) as Available
	                                        else
		                                        select cast(1 as bit) as Available
	

                                    ", subjectID.ToString());
        }

        private string GenerateSQLToEnableSubjectByModifyingSproc()
        {
            return String.Format(@" 
                                        alter proc spBulkStatusUpdateIsSubjectAvailable @SubjectID int
                                        as
	                                        if exists(select null from BulkStatusUpdateQueue where subjectID = @subjectID)
		                                        select cast(0 as bit) as Available
	                                        else
		                                        select cast(1 as bit) as Available
	

                                    ");
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
		public class DBScripts
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
            /// Generate SQL for number of CV Projects for a project name
            /// </summary>
            /// <param name="projectName">The name of the project for which Clinical Views exist</param>
            /// <returns>The number of CV Projects matching project name</returns>
            public static string GenerateSQLForNumberOfCVProjects(string projectName)
            {
                return CountOfCVProjects(projectName);
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

            /// <summary>
            /// Generate SQL for number of subjects that need to be signed through core service
            /// </summary>
            /// <returns>SQL string for number of subjects that need to be signed through core service</returns>
            public static string GenerateSQLForBulkSignaturesThatAreCurrentlyProcessed()
            {
                return String.Format(@" 
                                        select count(subjectID)
                                        from bulkstatusupdatequeue 
                                    ");
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

            private static string CountOfCVProjects(string project)
            {
                return String.Format(@"     select count(p.projectID) 
                                            from clinicalviewProjects cvp
	                                            join projects p
		                                            on p.projectID = cvp.projectID
                                            where dbo.fnlocaldefault(projectName) = '{0}'
                                    ", project);
            }
            
            /// <summary>
            /// generates SQL to verify existence of architect audits
            /// </summary>
            /// <param name="audit">audit message</param>
            /// <param name="user">user</param>
            /// <param name="projectName">project name</param>
            /// <param name="draftName">draft name</param>
            /// <param name="auditSubCategory">audit sub-category</param>
            /// <param name="property">property value in audits</param>
            /// <returns></returns>
            public static string GenerateArchitectAudits(string audit, string user, string projectName, 
                                            string draftName, string auditSubCategory, string property)
            {
                return String.Format(@"     
                                            select top 1 null 
                                            from vaudits va
                                                join users u
                                                    on u.userID = va.auditUserID
                                                join crfDrafts crf
                                                    on crf.crfDraftID = va.objectID
                                                join projects p
                                                    on p.projectID = crf.projectID
												join auditSubCategoryR r
                                                    on r.ID = va.auditSubCategoryID
                                            where locale = 'eng' 
	                                            and objectTypeID = 108
	                                            and readable like '{0}'
                                                and login = '{1}'
                                                and dbo.fnlocaldefault(projectName) = '{2}'
                                                and dbo.fnlocaldefault(crfDraftNameID) = '{3}'
                                                and r.name = '{4}'
                                                and va.property = '{5}'
                                             ", audit, user, projectName, draftName, auditSubCategory, property);
            }

            /// <summary>
            /// Generate sql to delete all architect audits
            /// </summary>
            /// <param name="user">username of user, for whom to delete audits</param>
            /// <returns></returns>
            public static string GenerateDeleteAllArchitectAudits(string user)
            {
                return String.Format(@"     delete a
                                            from audits a
	                                            join users u
		                                            on u.userID = a.auditUserID
                                            where objectTypeID = 108
                                                and login = '{0}'
                                             ", user);
                   
            }
		}
	}
}
