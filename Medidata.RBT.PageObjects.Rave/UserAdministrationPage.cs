using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public  class UserAdministrationPage : PageBase
	{
		[FindsBy(How = How.Id, Using = "_ctl0_Content_AuthenticatorDDL")]
		IWebElement Authenticator;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_LastNameBox")]
		IWebElement LastName;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_SiteFilterBox")]
		IWebElement Site;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_RoleDDL")]
		IWebElement Role;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_StudyDDL")]
		IWebElement Study;

		[FindsBy(How = How.Id, Using = "_ctl0_Content_LoginBox")]
		IWebElement Login;


		[FindsBy(How = How.Id, Using = "_ctl0_Content_SearchButtonLnk")]
		IWebElement Search;
		

		public struct SearchBy
		{
			public string LastName { get; set; }
			public string Login { get; set; }
			public string Authenticator { get; set; }
			public string Site { get; set; }
			public string Role { get; set; }

			public string Study { get; set; }
		}

		public UserAdministrationPage SearchUser(NameValueCollection filters)
		{
			SearchBy filter = new SearchBy();
			foreach (string key in filters.AllKeys)
			{
				switch (key)
				{
					case "Log In":
						filter.Login = filters[key];
						break;
					case "Last Name":
						filter.LastName = filters[key];
						break;
					case "Authenticator":
						filter.Authenticator = filters[key];
						break;
					case "Site":
						filter.Site = filters[key];
						break;
					case "Role":
						filter.Role = filters[key];
						break;
					case "Study":
						filter.Study = filters[key];
						break;
				}
			}

			return SearchUser(filter);
		}

		public UserAdministrationPage SearchUser(SearchBy by)
		{
			if (by.Authenticator != null)
				new SelectElement(Authenticator).SelectByText(by.Authenticator);

			if (by.LastName != null)
				LastName.EnhanceAs<Textbox>().SetText(by.LastName);

			if (by.Site != null)
				Site.EnhanceAs<Textbox>().SetText(by.Site);

			if (by.Login != null)
				Login.EnhanceAs<Textbox>().SetText(by.Login);

			if (by.Role != null)
				new SelectElement(Role).SelectByText(by.Role);

			if (by.Study != null)
				new SelectElement(Study).SelectByText(by.Study);

			Search.Click();

			return this;
		}

		public UserEditPage ClickUser(string userName)
		{
			try
			{
				var resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_UserGrid"));
				var link = resultTable.TryFindElementBy(By.XPath("tbody/tr[position()>1]/td[position()=1 and text()='" + userName + "']/../td[position()=8]/a"));

				link.Click();
			}
			catch
			{
				throw new Exception("User not found in result table: "+userName);
			}
			return new UserEditPage();
		}
	}
}
