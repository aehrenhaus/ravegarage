using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Reflection;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
namespace Medidata.RBT.PageObjects.Rave
{
	public class AuditsPage : RavePageBase
	{
		//TODO: support wild char or regex
		public bool AuditExist(AuditModel audit, int? position = null)
		{
			if (audit.AuditType == "Query Canceled")
			{
				return AuditExist_CancelQuery(audit.QueryMessage, audit.User, audit.Time, position);
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
                return AuditExist_UserEntered(audit.QueryMessage, audit.User, audit.Time, position);
            }

            else if (audit.AuditType == "DataPoint")
            {
                return AuditExist_DataPoint(audit.QueryMessage, audit.User, audit.Time, position);
            }

            else if (audit.AuditType == "Add Events")
            {
                return AuditExist_AddEvents(audit.QueryMessage, audit.User, audit.Time, position);
            }

            else if (audit.AuditType == "Record")
            {
                return AuditExist_Record(audit.QueryMessage, audit.User, audit.Time, position);
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
		public bool AuditExist(string message,string user, string timeFormat, int? position = null)
		{
			IWebElement table = Browser.TryFindElementByPartialID("AuditsGrid");

            bool? isSpecifiedData = null;
            int auditPosition = 0;

            if (position.HasValue)
            {
                //Since first row in every column will be column header text
                auditPosition = position.Value + 1;
                if (!string.IsNullOrEmpty(message))
                {
                    var auditTD = table.FindElement(By.XPath("./tbody/tr[" + auditPosition +
                        "]/td[1]"));
                    isSpecifiedData = auditTD.Text.Equals(message);
                    if (!isSpecifiedData.Value)
                        return isSpecifiedData.Value;
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(message))
                {
                    var auditTDs = table.FindElements(By.XPath("./tbody/tr[position()>1]/td[1]"));
                    var td = auditTDs.FirstOrDefault(x => x.Text.Contains(message));
                    
                    if (td != null)
                    {
                        auditPosition = auditTDs.IndexOf(td) + 1;
                    }

                    isSpecifiedData = (td != null);
                    if (!isSpecifiedData.Value)
                        return isSpecifiedData.Value;
                }
            }

            if (!string.IsNullOrEmpty(user) && auditPosition > 0)
            {
                var auditUser = table.FindElement(By.XPath("./tbody/tr[" + auditPosition +
                "]/td[2]"));

                string[] specifiedUserDetail = user.Split('(', ')');
                string[] actualUserDetail = auditUser.Text.Split('(', ')');

                string specifiedFirstName = specifiedUserDetail[0].TrimEnd(' ');
                string actualFirstName = actualUserDetail[0].TrimEnd(' ');
                isSpecifiedData = actualFirstName.Equals(specifiedFirstName);

                if (specifiedUserDetail.FirstOrDefault().Equals("System"))
                    return actualUserDetail.FirstOrDefault().Equals("System");

                string specifiedLogin = specifiedUserDetail[1].Split('-')[1].TrimStart(' ');
                //Get the unique user object created during seeding
                User spUser = TestContext.GetExistingFeatureObjectOrMakeNew(specifiedLogin, () => new User(specifiedLogin, false));

                string actualLogin = actualUserDetail[1].Split('-')[1].TrimStart(' ');
                isSpecifiedData = actualLogin.Equals(spUser.UniqueName);

                if (!isSpecifiedData.Value)
                    return isSpecifiedData.Value;
            }

            if (!string.IsNullOrEmpty(timeFormat) && auditPosition > 0)
            {
                var auditTimeFormat = table.FindElement(By.XPath("./tbody/tr[" + auditPosition +
                "]/td[3]"));

                //Check if data in specified date time format exist
                DateTime dt;
                isSpecifiedData = DateTime.TryParse(auditTimeFormat.Text, out dt);
                if (!isSpecifiedData.Value)
                    return isSpecifiedData.Value;
            }

            if (isSpecifiedData.HasValue)
                return isSpecifiedData.Value;
            else 
                return false;	
		}
        
		public bool AuditExist_OpenQuery(string query, string user, string timeFormat, int? position = null)
		{
            return AuditExist(string.Format("User opened query '{0}'", query), user, timeFormat, position);
		}

		public bool AuditExist_CancelQuery(string query, string user, string timeFormat, int? position = null)
		{
            return AuditExist(string.Format("Query '{0}' canceled", query), user, timeFormat, position);
		}

        public bool AuditExist_SignatureSucceeded(int? position = null)
        {
            return AuditExist("User signature succeeded", null, null, position);
        }

        public bool AuditExist_SignatureBroken(int? position = null)
        {
            return AuditExist("Signature has been broken", null, null, position);
        }

        public bool AuditExist_UserEntered(string userInput,string user, string timeFormat, int? position = null)
        {
            return AuditExist(string.Format("User entered {0}", userInput), user, timeFormat, position); 
        }

        public bool AuditExist_DataPoint(string query, string user, string timeFormat, int? position = null)
        {
            return AuditExist(string.Format("DataPoint {0}", query), user, timeFormat, position);
        }

        /// <summary>
        /// Check if the specified audit exists against a record
        /// </summary>
        /// <param name="query">The words that come after record</param>
        /// <param name="user">The user who made the audit</param>
        /// <param name="timeFormat">The format that the time is in</param>
        /// <param name="position"></param>
        /// <returns></returns>
        public bool AuditExist_Record(string query, string user, string timeFormat, int? position = null)
        {
            return AuditExist(string.Format("Record {0}", query), user, timeFormat, position);
        }

        private bool AuditExist_AddEvents(string query, string user, string timeFormat, int? position)
        {
            return AuditExist(string.Format("Add events {0}", query), user, timeFormat, position);
        }

        public override string URL { get { return "AuditsPage.aspx"; } }

	}
}
