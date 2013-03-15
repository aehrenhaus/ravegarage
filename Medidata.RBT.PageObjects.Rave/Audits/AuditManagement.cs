using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.Audits
{
    public sealed class AuditManagement
    {
        private static readonly AuditManagement m_instance = new AuditManagement();

        private AuditManagement() { }

        public static AuditManagement Instance
        {
            get
            {
                return m_instance;
            }
        }

        /// <summary>
        /// Get the audit message to look for by the audit type and the query information
        /// </summary>
        /// <param name="auditType">The type of the audit made</param>
        /// <param name="auditQueryMessage">The information included in the audit</param>
        /// <returns>The audit message that is created using these pieces of information</returns>
        public string GetAuditMessage(
            string auditType,
            string auditQueryMessage
            )
        {
            switch (auditType.ToLower())
            {
                case "query canceled":
                    return string.Format("Query '{0}' canceled", auditQueryMessage);
                case "signature succeeded":
                    return "User signature succeeded.";
                case "signature broken":
                    return "Signature has been broken.";
                case "user entered":
                    return string.Format("User entered {0}", auditQueryMessage);
                case "datapoint":
                    return string.Format("DataPoint {0}", auditQueryMessage);
                case "add events":
                    return string.Format("Add events {0}", auditQueryMessage);
                case "ladd events":
                    return string.Format("LAdd events {0}", auditQueryMessage);
                case "record":
                    return string.Format("Record {0}", auditQueryMessage);
                case "reviewed":
                    return string.Format("Reviewed for {0}.", auditQueryMessage);
                case "un-reviewed":
                    return string.Format("Un-reviewed for {0}.", auditQueryMessage);
                case "amendment manager":
                case "lamendment manager":
                    return string.Format("{0}: {1}", auditType, auditQueryMessage);
                case "clinical significance set":
                    return string.Format("Clinical significance {0} set.", auditQueryMessage);
            }

            throw new Exception("Invalid audit type " + auditType);
        }
    }
}
