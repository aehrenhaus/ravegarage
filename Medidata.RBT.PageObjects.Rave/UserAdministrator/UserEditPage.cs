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
        /// <param name="project">The project to assign the user to</param>
        /// <param name="role">The role to assign the user to</param>
        /// <param name="environment">The environment to assign the user to</param>
        /// <param name="site">The site to assign the user to</param>
        /// <param name="securityRole">The securityRole to assign the user to</param>
        public void AssignUserToPermissions(Project project, Role role, string environment, Site site, SecurityRole securityRole)
        {
            ClickLink("Assign to Study");
            ChooseFromDropdown("_ctl0_Content_UserSiteWizard1_SelectRoleDDL", role.UniqueName);
            ChooseFromDropdown("_ctl0_Content_UserSiteWizard1_ProjectDDL", project.UniqueName);
            ChooseFromDropdown("_ctl0_Content_UserSiteWizard1_AuxStudiesDDL", environment);
            ClickLink("Assign User");

            ClickLink("Assign To Project");
            ChooseFromDropdown("_ctl0_Content_UserSecurityWizard1_DdlSelectRole", securityRole.UniqueName);
            ClickLink("Assign");

            AssignUserToSite(project.UniqueName, role.UniqueName, site.UniqueName, site.Number);
        }

        /// <summary>
        /// Assign the user to a site
        /// </summary>
        /// <param name="studyName">The study to assign the user to</param>
        /// <param name="roleName">The role to assign the user to</param>
        /// <param name="siteName">The site name to assign the user to</param>
        /// <param name="siteNumber">The site number to assign the user to</param>
        public void AssignUserToSite(string studyName, string roleName, string siteName, string siteNumber)
        {
            int foundOnPage;
            IWebElement studyRoleRow = this.FindInPaginatedList("", () =>
            {
                IWebElement resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_UserSiteWizard1_UserGrid"));
                IWebElement row = resultTable.TryFindElementBy(By.XPath("tbody/tr[position()>1]/td[position() = 1 and text() = '"
                    + studyName + ": Prod']/../td[position()=2 and text()='" + roleName + "']/.."));
                return row;
            }, out foundOnPage);

            IWebElement siteButton = studyRoleRow.TryFindElementByPartialID("Imagebutton2");
            siteButton.Click();
            Browser.WaitForElement(By.Id("_ctl0_Content_UserSiteWizard1_StudySiteGrid"), "StudySites did not load", 60);
            IWebElement siteRowToSelect = this.FindInPaginatedList("", () =>
            {
                IWebElement resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_UserSiteWizard1_StudySiteGrid"));
                IWebElement row = resultTable.TryFindElementBy(By.XPath("tbody/tr[position()>1]/td[position()=1 and contains(text(),'" + siteName + "')]/../"
                    + "td[position()=2 and contains(text(),'" + siteNumber + "')]/.."));
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
        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;
        int secondPageIndex = 1;
        int secondCount = 0;
        int secondLastValue = -1;

        public bool GoNextPage(string areaIdentifier)
        {
            IWebElement studyTable = TestContext.Browser.TryFindElementById("_ctl0_Content_UserSiteWizard1_UserGrid");
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
