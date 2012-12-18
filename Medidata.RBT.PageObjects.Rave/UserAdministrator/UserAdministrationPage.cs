using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
namespace Medidata.RBT.PageObjects.Rave
{
	public class UserAdministrationPage : RavePageBase, IHavePaginationControl
	{
        [FindsBy(How = How.Id, Using = "_ctl0_Content_AuthenticatorDDL")]
        IWebElement Authenticator { get; set; }

		[FindsBy(How = How.Id, Using = "_ctl0_Content_LastNameBox")]
        IWebElement LastName { get; set; }

		[FindsBy(How = How.Id, Using = "_ctl0_Content_SiteFilterBox")]
        IWebElement Site { get; set; }

		[FindsBy(How = How.Id, Using = "_ctl0_Content_RoleDDL")]
        IWebElement Role { get; set; }

		[FindsBy(How = How.Id, Using = "_ctl0_Content_StudyDDL")]
        IWebElement Study { get; set; }

		

		public class SearchByModel
		{
			public string LastName { get; set; }
			public string Login { get; set; }
			public string Authenticator { get; set; }
			public string Site { get; set; }
			public string Role { get; set; }

			public string Study { get; set; }

            public bool Architect { get; set; }
            public bool AmendmentManager { get; set; }
		}

        /// <summary>
        /// Search for a user
        /// </summary>
        /// <param name="by">What to search to find the user</param>
        /// <returns>The current UserAdministrationPage</returns>
		public UserAdministrationPage SearchUser(SearchByModel by)
		{
			if (by.Authenticator != null)
				new SelectElement(Authenticator).SelectByText(by.Authenticator);

			if (by.LastName != null)
				LastName.EnhanceAs<Textbox>().SetText(by.LastName);

			if (by.Site != null)
				Site.EnhanceAs<Textbox>().SetText(by.Site);


			if (by.Login != null)
			{
				var Login = Browser.TryFindElementById("_ctl0_Content_LoginBox");
				Login.EnhanceAs<Textbox>().SetText(by.Login);
			}

	        if (by.Role != null)
				new SelectElement(Role).SelectByText(by.Role);

			if (by.Study != null)
				new SelectElement(Study).SelectByText(by.Study);

			var Search = Browser.TryFindElementById("_ctl0_Content_SearchButtonLnk");
			Search.Click();

			return this;
		}

		#region Pagination

		public ICanPaginate GetPaginationControl(string areaIdentifier)
		{
			var pageTable = TestContext.Browser.TryFindElementById("_ctl0_Content_UserGrid").TryFindElementBy(By.XPath("./tbody/tr[last()]"));
			var pager = new RavePaginationControl_CurrentPageNotLink(this, pageTable);
			return pager;
		}

		#endregion

		/// <summary>
        /// Click a user on the UserAdministrationPage.
        /// </summary>
        /// <param name="userName">The unique user name to click</param>
        /// <returns>The UserEditPage for the user</returns>
		public UserEditPage ClickUser(string userName)
		{
			int foundOnPage;
			IWebElement userLink = this.FindInPaginatedList("", () =>
			{
				Thread.Sleep(500);//wiat for while, although the TryFindElementByXPath will wait anyway, the Exception is always showing in debug mode

				var resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_UserGrid"));
				var link = resultTable.TryFindElementBy(By.XPath("tbody/tr[position()>1]/td[position()=1 and text()='" + userName + "']/../td[position()=7]/a"),false);
				return link;

			}, out foundOnPage);

			if(userLink == null)
				throw new Exception("User not found in result table: "+userName);

            userLink.Click();
			return new UserEditPage();
		}

        /// <summary>
        /// Click the a user on the page
        /// </summary>
        /// <param name="userName">The unique name of the user to click</param>
        /// <returns>The UserActivationPage of the user</returns>
        public UserActivationPage ClickActivated(string userName)
        {
            int foundOnPage;
            IWebElement userLink = this.FindInPaginatedList("", () =>
            {
                var resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_UserGrid"));
                var link = resultTable.TryFindElementBy(By.XPath("tbody/tr[position()>1]/td[position()=1 and text()='" + userName + "']/../td[position()=6]/a"));
                return link;

            }, out foundOnPage);

            if (userLink == null)
                throw new Exception("User not found in result table: " + userName);

            userLink.Click();
            return new UserActivationPage();
        }

		public override string URL
		{
			get
			{
				return "Modules/UserAdmin/UsersPage.aspx";
			}
		}

	}
}
