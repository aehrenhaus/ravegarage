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
using Medidata.RBT.PageObjects.Rave.Audits;

namespace Medidata.RBT.PageObjects.Rave
{
    public class AuditsPage : RavePageBase, IVerifyAudits
	{
        private static readonly string[] s_sysUsers = new[] { "System", "LSystem" };

        public bool ExactAuditExist(AuditModel audit, int? position = null)
        {
            return AuditExist(audit.Audit, audit.User, audit.Time, position);
        }

        //TODO: support wild char or regex
        public bool AuditExist(AuditModel audit, int? position = null)
        {
            return AuditExist(AuditManagement.Instance.GetAuditMessage(audit.AuditType,
                audit.QueryMessage != null ? audit.QueryMessage.Split(',').ToList() : null), 
            audit.User, audit.Time, position);
        }

        /// <summary>
        /// Overriding ChooseFromDropdown to find the dropdown based on field name, if drop down selected fails then fall back to base implementation
        /// </summary>
        /// <param name="identifier">Dropdown identifier</param>
        /// <param name="text">Text to select in the dropdown</param>
        /// <param name="objectType">Object type of dropdown</param>
        /// <param name="areaIdentifier">Area the dropdown exists in</param>
        /// <returns></returns>
        public override IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
            if(identifier.Equals("Siblings Dropdown", StringComparison.InvariantCultureIgnoreCase))
                return base.ChooseFromDropdown("_ctl0_Content_AuditSelector_Children", text, objectType, areaIdentifier);

            return base.ChooseFromDropdown(identifier, text, objectType, areaIdentifier);
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
                        auditPosition = auditTDs.IndexOf(td) + 2;
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

                if (s_sysUsers.Contains(specifiedUserDetail.FirstOrDefault()))
                {
                    isSpecifiedData = s_sysUsers.Contains(actualUserDetail.FirstOrDefault());
                }
                else
                {

                    string specifiedLogin = specifiedUserDetail[1].Split('-')[1].TrimStart(' ');
                    //Get the unique user object created during seeding
                    User spUser = SeedingContext.GetExistingFeatureObjectOrMakeNew(specifiedLogin, () => new User(specifiedLogin));

                    string actualLogin = actualUserDetail[1].Split('-')[1].TrimStart(' ');
                    isSpecifiedData = actualLogin.Equals(spUser.UniqueName);
                }

                if (!isSpecifiedData.Value)
                    return isSpecifiedData.Value;
            }

            if (!string.IsNullOrEmpty(timeFormat) && auditPosition > 0)
            {
                var auditTimeFormat = table.FindElement(By.XPath("./tbody/tr[" + auditPosition +
                "]/td[3]"));

                //Check if data in specified date time format exist
                DateTime dt;
                string dateTimeValStr = auditTimeFormat.Text;

                //Check for Localized Test 'loc' date time format if applied
                if (dateTimeValStr.Contains('L'))
                {
                    string[] auditTextArr = dateTimeValStr.Split(' ');
                    if (auditTextArr != null && auditTextArr.Length > 1 && 
                        auditTextArr[1].StartsWith("L"))
                    {
                        auditTextArr[1] = auditTextArr[1].TrimStart('L');
                        dateTimeValStr = string.Join(" ", auditTextArr);
                    }
                }

                DateTime.TryParse(dateTimeValStr, out dt);
                try
                {
                    //Add check for localization
                    string dateTimeTxtFromFormat = dt.ToString(timeFormat);
                    if (!string.IsNullOrEmpty(dateTimeTxtFromFormat) && dateTimeTxtFromFormat.Equals(auditTimeFormat.Text))
                        isSpecifiedData = true;
                    else
                        isSpecifiedData = false;
                }
                catch (System.FormatException)
                {
                    isSpecifiedData = false;
                    return isSpecifiedData.Value;
                }

                if (!isSpecifiedData.Value)
                    return isSpecifiedData.Value;
            }

            if (isSpecifiedData.HasValue)
                return isSpecifiedData.Value;
            else 
                return false;	
		}

        public override string URL { get { return "Modules/EDC/AuditsPage.aspx"; } }
    }
}
