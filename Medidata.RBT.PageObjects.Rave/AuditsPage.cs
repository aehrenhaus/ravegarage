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
		public bool AuditExist(string message, bool isLatest = false)
		{
			IWebElement table = Browser.TryFindElementByPartialID("AuditsGrid");
			var auditTDs = table.FindElements(By.XPath("./tbody/tr[position()>1]/td[1]"));

			var td = auditTDs.FirstOrDefault(x => x.Text == message);


			return td!=null;
		}

		public bool AuditExist_OpenQuery(string query, bool isLatest = false)
		{
			return AuditExist(string.Format ("User opened query '{0}' (Site).",query), isLatest);
		}

		public bool AuditExist_CloseQuery(string query, bool isLatest = false)
		{
			return AuditExist(string.Format("Query '{0}' canceled (Site).",query), isLatest);
		}
	}
}
