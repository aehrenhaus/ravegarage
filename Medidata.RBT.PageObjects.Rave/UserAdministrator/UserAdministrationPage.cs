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
	public  class UserAdministrationPage : PageBase, ICanPaginate
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
		

		public class SearchByModel
		{
			public string LastName { get; set; }
			public string Login { get; set; }
			public string Authenticator { get; set; }
			public string Site { get; set; }
			public string Role { get; set; }

			public string Study { get; set; }
		}


		public UserAdministrationPage SearchUser(SearchByModel by)
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

			int foundOnPage;
			IWebElement userLink = this.FindInPaginatedList("", () =>
			{
				var resultTable = Browser.TryFindElementBy(By.Id("_ctl0_Content_UserGrid"));
				var link = resultTable.TryFindElementBy(By.XPath("tbody/tr[position()>1]/td[position()=1 and text()='" + userName + "']/../td[position()=8]/a"));
				return link;

			}, out foundOnPage);



			if(userLink == null)
				throw new Exception("User not found in result table: "+userName);
			
			return new UserEditPage();
		}

		public override string URL
		{
			get
			{
				return "Modules/UserAdmin/UsersPage.aspx";
			}
		}	int pageIndex = 1;
		int count = 0;
		int lastValue = -1;

		public bool GoNextPage(string areaIdentifer)
		{
			var pageTable = TestContext.Browser.TryFindElementById("_ctl0_Content_UserGrid").TryFindElementBy(By.XPath("./tbody/tr[last()]"));

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
			return true;
		}

		public bool GoPreviousPage(string areaIdentifer)
		{
			throw new NotImplementedException();
		}

		public bool GoToPage(string areaIdentifer, int page)
		{
			throw new NotImplementedException();
		}

		public bool CanPaginate(string areaIdentifer)
		{
			return true;
		}
	}
}
