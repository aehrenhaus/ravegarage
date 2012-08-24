using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;

namespace Medidata.RBT.DBScripts
{
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
