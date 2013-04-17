using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

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
            List<string> auditQueryMessage
            )
        {
            switch (auditType.ToLower())
            {
                case "query canceled":
                    return string.Format("Query '{0}' canceled", auditQueryMessage.FirstOrDefault());
                case "signature succeeded":
                    return "User signature succeeded.";
                case "signature broken":
                    return "Signature has been broken.";
                case "user entered":
                    return string.Format("User entered {0}", auditQueryMessage.FirstOrDefault());
                case "datapoint":
                    return string.Format("DataPoint {0}", auditQueryMessage.FirstOrDefault());
                case "add events":
                    return string.Format("Add events {0}", auditQueryMessage.FirstOrDefault());
                case "ladd events":
                    return string.Format("LAdd events {0}", auditQueryMessage.FirstOrDefault());
                case "record":
                    return string.Format("Record {0}", auditQueryMessage.FirstOrDefault());
                case "reviewed":
                    return string.Format("Reviewed for {0}.", auditQueryMessage.FirstOrDefault());
                case "un-reviewed":
                    return string.Format("Un-reviewed for {0}.", auditQueryMessage.FirstOrDefault());
                case "sticky":
                    return string.Format("Sticky note '{0}' placed for Site.", auditQueryMessage.FirstOrDefault());
                case "coding":
                    return string.Format("User coded data point as Term Coded data point by User: {0} - {1} version {2}.",
                        SeedingContext.GetExistingFeatureObjectOrMakeNew<User>(auditQueryMessage[0].Trim(), () => { throw new Exception("User not seeded"); }).UniqueName, auditQueryMessage[1].Trim(), auditQueryMessage[2].Trim());
                case "amendment manager":
                case "lamendment manager":
                    return string.Format("{0}: {1}", auditType, auditQueryMessage.FirstOrDefault());
                case "clinical significance set":
                    return string.Format("Clinical significance {0} set.", auditQueryMessage.FirstOrDefault());
                case "clinical significance prompt created":
                    return string.Format("Clinical significance prompt created.", auditQueryMessage.FirstOrDefault());
                case "data entry above range":
                    return string.Format("Data entry of {0} is Above the Range of {1}.", auditQueryMessage.FirstOrDefault().Trim(), auditQueryMessage[1].Trim());
                case "lab range status changed":
                    return string.Format("Lab Range Status Changed from {0} to {1}.", auditQueryMessage.FirstOrDefault().Trim(), auditQueryMessage[1].Trim());
                case "analyte range set":
                    return string.Format("Analyte Range Set to {0}.", auditQueryMessage.FirstOrDefault());
                case "subject assigned to tsdv":
                    return string.Format("Subject assigned to '{0}' in Targeted SDV.", auditQueryMessage.FirstOrDefault().Trim());
            }

            throw new Exception("Invalid audit type " + auditType);
        }
    }
}
