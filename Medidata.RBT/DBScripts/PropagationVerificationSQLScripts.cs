using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

namespace Medidata.RBT.DBScripts
{
    public class PropagationVerificationSQLScripts
    {
        public static string GenerateSQLQueryForColumnName(string column, int datapageID)
        {
            if (column.Equals("AltCodedValue"))
                return AltCodedValuePropagateForDatapageIDScript(datapageID);
            else
                throw new NotImplementedException("Propagation verificaiton for " + column + " not implemented");

        }
        private static string AltCodedValuePropagateForDatapageIDScript(int datapageID)
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
    }
}
