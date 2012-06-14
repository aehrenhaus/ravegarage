using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

namespace Medidata.RBT
{
    class NextSubjectNumReplace : IStringReplace
    {

        public string Replace(string input)
        {
            Regex regex_MaxSub = new Regex(@"{nextNumberInStudy\((?<project>.+?),(?<env>.+?),(?<numfield>.+?)\)}");
            return regex_MaxSub.Replace(input, match =>
            {
                return GetNextSubNum(match.Groups["project"].Value, match.Groups["env"].Value, match.Groups["numfield"].Value);
                //return null;
            });
        }

        private  string GetNextSubNum(string project, string env, string field)
        {
            int next = 0;

            try
            {
                string SQLquery = String.Format(@"select top 1 data
                                                from datapages dpg
	                                                join datapoints d
		                                                on d.datapageID = dpg.datapageID
			                                                and d.deleted <> 1
			                                                and d.dataActive = 1
                                                            and isnull(d.data, '') <> ''
	                                                join fields fi
		                                                on fi.fieldID = d.fieldID
                                                where dbo.fnlocaldefault(pretextID) =  '{2}'
                                                and isPrimaryDataPage = 1 and dpg.subjectID in 
	                                                (	select s.subjectID 
		                                                from subjects s
			                                                join studysites ss
				                                                on ss.studySiteID = s.studySiteID
			                                                join studies st
				                                                on st.studyID = ss.studyID
			                                                join projects p
				                                                on p.projectID = st.projectID
					                                                where dbo.fnlocaldefault(ProjectName) = '{0}' 
					                                                and dbo.fnlocaldefault(environmentNameID) = 'prod'
		                                                )
		                                         order by dpg.subjectID desc
                                    ", project.Replace("'", "''"), env.Replace("'", "''"), field.Replace("'", "''"));

                using (SqlCommand cmdCreateSS = new SqlCommand(SQLquery, new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings[RBTConfiguration.Default.DatabaseConnection].ConnectionString))) 
                {
                    cmdCreateSS.Connection.Open();
                    next = int.Parse(cmdCreateSS.ExecuteScalar() as string) + 1;
                    cmdCreateSS.Connection.Close();
                }
			
                //TODO: strip out special characters.  right now we just take care of apostrophe
            }
            catch
            {
                throw new Exception("Failed to get next subject Number");
            }

            return next.ToString();
        }
    }
}
