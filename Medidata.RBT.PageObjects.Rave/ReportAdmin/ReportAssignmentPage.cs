using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ReportAssignmentPage : RavePageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/ReportAdmin/ReportAdmin.aspx";
            }
        }

        /// <summary>
        /// Assign the specified report to specified user
        /// </summary>
        /// <param name="reportName">Name of report to be assigned</param>
        /// <param name="UserName">Name of the user to assign report to</param>
        /// <returns></returns>
        public IPage SelectReportAssignment(string reportName, User user)
        {
            if (user.ReportAssignments == null)
                user.ReportAssignments = new List<ReportAssignment>();
            user.ReportAssignments.Add(new ReportAssignment(reportName));

            //Choose report from dropdown, find the user and select it
            ChooseFromDropdown("_ctl0_Content_ReportsDDL", reportName);
            ClickButton("_ctl0_Content_UserSelectDG_EditBtn");

            Browser.FindElementById("_ctl0_Content_UserSelectDG_FilterBox")
                .EnhanceAs<Textbox>().SetText(user.UniqueName);

            ClickButton("_ctl0_Content_UserSelectDG_Search");

            IWebElement logInTableElem = Browser.TryFindElementById("_ctl0_Content_UserSelectDG_DisplayGrid");
            if (logInTableElem != null)
            {
                IWebElement logInNameElem = logInTableElem.FindElementsByText<IWebElement>(user.UniqueName).First();

                if (logInTableElem != null)
                {
                    logInTableElem.Parent().TryFindElementByPartialID("SelectionBox")
                        .EnhanceAs<Checkbox>().Check();

                    ClickButton("_ctl0_Content_UserSelectDG_EditBtn");
                }
            }

            this.ClickLink("Update Report Assignments");
            return this;
        }

        /// <summary>
        /// Assign the specified report to specified role
        /// </summary>
        /// <param name="reportName">Name of report to be assigned</param>
        /// <param name="role">Name of the role to assign report to</param>
        /// <returns></returns>
        public IPage SelectReportAssignment(string reportName, Role role)
        {
            if (role.ReportAssignments == null)
                role.ReportAssignments = new List<ReportAssignment>();
            role.ReportAssignments.Add(new ReportAssignment(reportName));

            //Choose report from dropdown, find the role and select it
            ChooseFromDropdown("_ctl0_Content_ReportsDDL", reportName);
            ClickButton("_ctl0_Content_RolesSelectDG_EditBtn");

            Browser.FindElementById("_ctl0_Content_RolesSelectDG_FilterBox")
                .EnhanceAs<Textbox>().SetText(role.UniqueName);

            ClickButton("_ctl0_Content_RolesSelectDG_Search");

            IWebElement logInTableElem = Browser.TryFindElementById("_ctl0_Content_RolesSelectDG_DisplayGrid");
            if (logInTableElem != null)
            {
                IWebElement logInNameElem = logInTableElem.FindElementsByText<IWebElement>(role.UniqueName).First();

                if (logInTableElem != null)
                {
                    logInTableElem.Parent().TryFindElementByPartialID("SelectionBox")
                        .EnhanceAs<Checkbox>().Check();
                }
            }

            this.ClickLink("Update Report Assignments");
            return this;
        }
    }
}
