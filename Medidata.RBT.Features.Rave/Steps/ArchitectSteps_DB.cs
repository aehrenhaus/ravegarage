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
	public partial class ArchitectSteps
    {
		/// <summary>
		/// In a particular table, crf version, OIDs are unique
		/// </summary>
		/// <param name="project"></param>
		//[StepDefinition(@"I wait for Clinical View refresh to complete for project ""([^""]*)""")]
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

        private int CountOfOIDSForCRFVersionAndTable(int crfVersion, string tableName, string OID = "")
        {
            string singularName;

            if (tableName.EndsWith("ies"))
                singularName = tableName.Substring(0, tableName.Length - 3) + "y";
            else
                singularName = tableName.Substring(0, tableName.Length - 1);


            string OIDCondition = "";

            if (OID.Length > 0)
                OIDCondition = " and OID = '" + OID "'";

            string query = String.Format(@"     select count({0}ID) as count, OID
                                                from {1}
                                                where crfVersionID = {2}
                                                GROUP BY OID
                                                HAVING ( COUNT(OID) > 1 )
                                    ", singularName, tableName, crfVersion);
            return 0;
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

            public static string GenerateSQLForNumberOfRecordsInLabUpdateQueue()
            {
                return CountOfRecordsInLabUpdateQueue();
            }

            private static string CountOfRecordsInLabUpdateQueue()
			{
				return "select count(labUpdateQueueID) from labUpdateQueue";
            }

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
