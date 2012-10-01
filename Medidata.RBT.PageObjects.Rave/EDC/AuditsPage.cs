using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
namespace Medidata.RBT.PageObjects.Rave
{
	public class AuditsPage : RavePageBase
	{
		//TODO: support wild char or regex
		public bool AuditExist(AuditModel audit, int? position = null)
		{
			if (audit.AuditType == "Query Canceled")
			{
				return AuditExist_CancelQuery(audit.QueryMessage, position);
			}

            else if (audit.AuditType == "Signature Succeeded")
            {
                return AuditExist_SignatureSucceeded(position);
            }

            else if (audit.AuditType == "Signature Broken")
            {
                return AuditExist_SignatureBroken(position);
            }

            else if (audit.AuditType == "User entered")
            {
                return AuditExist_UserEntered(audit.QueryMessage, position);
            }

            else if (audit.AuditType == "DataPoint")
            {
                return AuditExist_DataPoint(audit.QueryMessage, position);
            }

			throw new Exception("Invalid audit type " + audit.AuditType);
		}
        
        /// <summary>
        /// Checks if the specified audit exists in the audit trail
        /// If postion is specified then checks for the passed audit at specific position
        /// else checks for the lastest audit matching the specified audit message
        /// </summary>
        /// <param name="message"></param>
        /// <param name="position"></param>
        /// <param name="isLatest"></param>
        /// <returns></returns>
		public bool AuditExist(string message, int? position = null)
		{
			IWebElement table = Browser.TryFindElementByPartialID("AuditsGrid");

            if (position.HasValue)
            {
                //Since first row in every column will be column header text
                int auditPosition = (int)position + 1;
                var auditTD = table.FindElement(By.XPath("./tbody/tr[" + auditPosition +
                    "]/td[1]"));

                return auditTD.Text.Equals(message);
            }
            else
            {
                var auditTDs = table.FindElements(By.XPath("./tbody/tr[position()>1]/td[1]"));
                var td = auditTDs.FirstOrDefault(x => x.Text.Contains(message));

                return td != null;
            }
			
		}

		public bool AuditExist_OpenQuery(string query, int? position = null)
		{
            return AuditExist(string.Format("User opened query '{0}'", query), position);
		}

		public bool AuditExist_CancelQuery(string query, int? position = null)
		{
            return AuditExist(string.Format("Query '{0}' canceled", query), position);
		}

        public bool AuditExist_SignatureSucceeded(int? position = null)
        {
            return AuditExist("User signature succeeded", position);
        }

        public bool AuditExist_SignatureBroken(int? position = null)
        {
            return AuditExist("Signature has been broken", position);
        }

        public bool AuditExist_UserEntered(string userInput, int? position = null)
        {
            return AuditExist(string.Format("User entered {0}", userInput), position); 
        }

        public bool AuditExist_DataPoint(string query, int? position = null)
        {
            return AuditExist(string.Format("DataPoint {0}", query), position);
        }

        public override string URL { get { return "AuditsPage.aspx"; } }
	}
}
