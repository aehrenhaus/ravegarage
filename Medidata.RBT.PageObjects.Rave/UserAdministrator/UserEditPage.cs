﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Threading;
namespace Medidata.RBT.PageObjects.Rave
{
	public class UserEditPage : RavePageBase, ICanPaginate
	{
		[FindsBy(How = How.Id, Using = "_ctl0_Content_TopSaveLnkBtn")]
		public IWebElement TopUpdate;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_SaveLnkBtn")]
		public IWebElement BottomUpdate;


		[FindsBy(How = How.Id, Using = "_ctl0_Content_ActiveChk")]
		public IWebElement Active;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_LoginBox")]
		public IWebElement LogIn;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_LockedOutChk")]
		public IWebElement Lockout;


		public bool ControlsAreDisabled(TechTalk.SpecFlow.Table table)
		{
			bool allDisabled = true;

			Dictionary<string, IWebElement> mapping = new Dictionary<string, IWebElement>();
			mapping["Top Update"] = TopUpdate;
			mapping["Bottom Update"] = BottomUpdate;
			mapping["Active"] = Active;
			mapping["Log In"] = LogIn;
			mapping["Locked Out"] = Lockout;
			

			foreach (var row in table.Rows)
			{
				if (mapping[row["Control"]].Enabled)
				{
					allDisabled = false;
					break;
				}
			}

			return allDisabled;
		}

        /// <summary>
        /// Assign the user to the permissions in the parameters
        /// </summary>
        /// <param name="user">The user to assign everything else to. Needed to keep track of its study assignments</param>
        /// <param name="project">The project to assign the user to</param>
        /// <param name="role">The role to assign the user to</param>
        /// <param name="environment">The environment to assign the user to</param>
        /// <param name="site">The site to assign the user to</param>
        public void AssignUserToPermissions(User user, Project project, Role role, string environment, Site site)
        {
            ClickLink("Assign to Study");
            ChooseFromDropdown("_ctl0_Content_UserSiteWizard1_SelectRoleDDL", role.UniqueName);
            ChooseFromDropdown("_ctl0_Content_UserSiteWizard1_ProjectDDL", project.UniqueName);
            ChooseFromDropdown("_ctl0_Content_UserSiteWizard1_AuxStudiesDDL", environment);
            ClickLink("Assign User");

            AssignUserToSite(project.UniqueName, role.UniqueName, site.UniqueName, site.Number, environment.Replace("Live: ", "").Replace("Aux: ", ""));

            if (user.StudyAssignments == null)
                user.StudyAssignments = new List<StudyAssignment>();
			user.StudyAssignments.Add(new StudyAssignment(project.UniqueName, role.UniqueName, site.UniqueName));
        }

        /// <summary>
        /// Assign the user to a security role
        /// </summary>
        /// <param name="user">The user to assign everything else to. Needed to keep track of its module assignments</param>
        /// <param name="securityRole">The securityRole to assign the user to</param>
        public void AssignUserToSecurityRole(User user, SecurityRole securityRole)
        {
            ClickLink("Assign To Project");
            ChooseFromDropdown("_ctl0_Content_UserSecurityWizard1_DdlSelectRole", securityRole.UniqueName);
            ClickLink("Assign");

            if (user.ModuleAssignments == null)
                user.ModuleAssignments = new List<ModuleAssignment>();
            user.ModuleAssignments.Add(new ModuleAssignment("All Projects", securityRole.UniqueName));
        }

        /// <summary>
        /// Assign the user to a global library role
        /// </summary>
        public void AssignUserToGlobalLibraryRole()
        {
            ChooseFromDropdown("_UserSecurityWizard1_DdlModule", "Architect Global Library");
            ClickLink("Assign To Global Library Volume");
            ChooseFromDropdown("_ctl0_Content_UserSecurityWizard1_DdlSelectRole", "Global Library Admin Default");
            ClickLink("Assign");
        }

        /// <summary>
        /// Assign the user to a site
        /// </summary>
        /// <param name="studyName">The study to assign the user to</param>
        /// <param name="roleName">The role to assign the user to</param>
        /// <param name="siteName">The site name to assign the user to</param>
        /// <param name="siteNumber">The site number to assign the user to</param>
        public void AssignUserToSite(string studyName, string roleName, string siteName, string siteNumber, string envName)
        {
            int foundOnPage;
			IWebElement studyRoleRow = this.FindInPaginatedList("", () =>
				                                                        {
					                                                        Thread.Sleep(500);
					                                                        IWebElement resultTable =
						                                                        Browser.TryFindElementBy(
							                                                        By.Id("_ctl0_Content_UserSiteWizard1_UserGrid"), true);

					                                                        IWebElement row =
						                                                        resultTable.TryFindElementByXPath(
							                                                        "tbody/tr[position()>1]/td[position() = 1 and text() = '"
							                                                        + studyName + ": " + envName +
							                                                        "']/../td[position()=2 and text()='" + roleName + "']/..",
							                                                        false);
					                                                        return row;
				                                                        }, out foundOnPage);

            IWebElement siteButton = studyRoleRow.TryFindElementByPartialID("Imagebutton2");
            siteButton.Click();
            var studyLink = Browser.TryFindElementByPartialID("_ctl0_Content_UserSiteWizard1_StudySiteGrid", true, 60);
			if (studyLink == null)
				throw new Exception("StudySites did not load");
            IWebElement siteRowToSelect = this.FindInPaginatedList("", () =>
            {
                IWebElement resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_UserSiteWizard1_StudySiteGrid"));
                IWebElement row = resultTable.TryFindElementBy(By.XPath("tbody/tr[position()>1]/td[position()=1 and contains(text(),'" + siteName + "')]/.."));
                return row;
            }, out foundOnPage);
            IWebElement siteCheckbox = siteRowToSelect.TryFindElementByPartialID("chkStudySite");
            siteCheckbox.EnhanceAs<Checkbox>().Check();
            Browser.TryFindElementById("_ctl0_Content_UserSiteWizard1_UpdateSSLnkBtn").Click();
        }

		public override string URL
		{
			get
			{
				return "Modules/UserAdmin/UsersDetails.aspx";
			}
        }

        #region ICanPaginate
        int pageIndex = 0;
        int count = 0;
        int lastValue = -1;
        int secondPageIndex = 1;
        int secondCount = 0;
        int secondLastValue = -1;

		public int CurrentPageNumber { get; private set; }

        public bool GoNextPage(string areaIdentifier)
        {
            IWebElement studyTable = TestContext.Browser.TryFindElementById("_ctl0_Content_UserSiteWizard1_UserGrid",true,2);

            if (studyTable != null)
            {
                var pageTable = studyTable.TryFindElementBy(By.XPath("./tbody/tr[last()]"));

                var pageLinks = pageTable.FindElements(By.XPath(".//a"));

                count = pageLinks.Count;
                if (pageIndex == count)
                    return false;

                while (!pageLinks[pageIndex].Text.Equals("...") && int.Parse(pageLinks[pageIndex].Text) <= lastValue && pageIndex <= count)
                {
                    pageIndex++;
                }

                if (pageLinks[pageIndex].Text.Equals("..."))
                {
                    lastValue = int.Parse(pageLinks[pageIndex - 1].Text);
                    pageLinks[pageIndex].Click();
                    pageIndex = 1;
                }
                else
                {
                    pageLinks[pageIndex].Click();
                    pageIndex++;
                }
            }
            else
            {
                var pageTable = TestContext.Browser.TryFindElementById("_ctl0_Content_UserSiteWizard1_StudySiteGrid").TryFindElementBy(By.XPath("./tbody/tr[last()]"));

                var pageLinks = pageTable.FindElements(By.XPath(".//a"));

                secondCount = pageLinks.Count;
                if (secondPageIndex == secondCount)
                    return false;

                while (!pageLinks[secondPageIndex].Text.Equals("...") && int.Parse(pageLinks[secondPageIndex].Text) <= secondLastValue && secondPageIndex <= secondCount)
                {
                    secondPageIndex++;
                }

                if (pageLinks[secondPageIndex].Text.Equals("..."))
                {
                    secondLastValue = int.Parse(pageLinks[secondPageIndex - 1].Text);
                    pageLinks[secondPageIndex].Click();
                    secondPageIndex = 1;
                }
                else
                {
                    pageLinks[secondPageIndex].Click();
                    secondPageIndex++;
                }
            }
            return true;
        }

        public bool GoPreviousPage(string areaIdentifier)
        {
            throw new NotImplementedException();
        }

        public bool GoToPage(string areaIdentifier, int page)
        {
            throw new NotImplementedException();
        }

        public bool CanPaginate(string areaIdentifier)
        {
            return true;
        }
        #endregion
    }
}
