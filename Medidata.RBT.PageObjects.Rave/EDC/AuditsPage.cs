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
		public bool AuditExist(AuditModel audit, bool isLatest = false)
		{
			if (audit.AuditType == "Query Canceled")
			{
				return AuditExist_CancelQuery(audit.QueryMessage, isLatest);
			}

            else if (audit.AuditType == "Signature Succeeded")
            {
                return AuditExist_SignatureSucceeded(isLatest);
            }

            else if (audit.AuditType == "Signature Broken")
            {
                return AuditExist_SignatureBroken(isLatest);
            }

			throw new Exception("Invalid audit type " + audit.AuditType);
		}

		public bool AuditExist(string message, bool isLatest = false)
		{
			IWebElement table = Browser.TryFindElementByPartialID("AuditsGrid");
			var auditTDs = table.FindElements(By.XPath("./tbody/tr[position()>1]/td[1]"));

			var td = auditTDs.FirstOrDefault(x => x.Text.Contains( message));


			return td!=null;
		}

		public bool AuditExist_OpenQuery(string query, bool isLatest = false)
		{
			return AuditExist(string.Format ("User opened query '{0}'",query), isLatest);
		}

		public bool AuditExist_CancelQuery(string query, bool isLatest = false)
		{
			return AuditExist(string.Format("Query '{0}' canceled",query), isLatest);
		}

        public bool AuditExist_SignatureSucceeded(bool isLatest = false)
        {
            return AuditExist("User signature succeeded", isLatest);
        }

        public bool AuditExist_SignatureBroken(bool isLatest = false)
        {
            return AuditExist("Signature has been broken", isLatest);
        }

        public override string URL { get { return "AuditsPage.aspx"; } }
	}
}
