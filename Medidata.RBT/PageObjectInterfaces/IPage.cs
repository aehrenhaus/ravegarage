using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Specialized;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT
{
	/// <summary>
	/// Represent a page 
	/// See 'page object pattern'
	/// Every actual url that are tested should have a corresponding page class, that implments IPage
	/// </summary>
	public interface IPage
	{
		/// <summary>
		/// The browser driver. Represents the browser
		/// </summary>
		RemoteWebDriver Browser { get; }

		/// <summary>
		/// Cast current object to a child type, just to support stream lined code style
		/// Example:
		/// CurrentPage is a IPage
		/// 
		/// Without the As() method, code would be
		/// <code>
		/// ((CurrentPage as UserAdministrationPage).SearchUser("user1").Choose("something") as UserAdministrationPage).ChooseUserFromResult("user1")
		/// </code>
		/// 
		/// With the As() method, code can be more streamlined:
		/// 
		/// <code>
		/// CurrentPage
		///		.As< UserAdministrationPage>()
		///		.SearchUser("user1")
		///		.Choose("something")
		///		.As<UserAdministrationPage>()
		///		.ChooseUserFromResult("user1")
		/// </code>
		/// </summary>
		TPage As<TPage>() where TPage : class, IPage;

		/// <summary>
		/// The absolute path (after the BaseURL part) that represents the page.
		/// Example: "Modules/AmendmentManager/MigrationResults.aspx"
		/// 
		/// URL property is not the actual url in the browser. 
		/// But is a static value of POClass that can be compared to the actual url or navigate.
		/// See NavigateToSelf() and IsThePage()
		/// </summary>
		string URL { get; }

		/// <summary>
		/// Example:
		/// https://rave564conlabtesting1.mdsol.com/MedidataRave/
		/// 
		/// This is the part that every page in a URL shares.
		/// 
		/// BaseURL combined with URL can form a full url that is valid
		/// </summary>
        string BaseURL { get; }

        /// <summary>
        /// Returns a control in a given page if it is found.
        /// </summary>
        /// <param name="identifier">ID of web element</param>
        IWebElement CanSeeControl(string identifier);

		/// <summary>
		/// Click a link in all page area.
		/// </summary>
		/// <param name="linkText"></param>
		/// <returns></returns>
		IPage ClickLink(string linkText);

		/// <summary>
		/// Click a hyperlink in a certen area.
		/// areaIdentifer not only points out the area, but also implies what is the target page type.
		/// 
		/// Example : when you want to click a 'Study' 'Study 123' in 'Header area'
		///
		/// </summary>
		/// <param name="linkText"></param>
		/// <param name="areaIdentifer"></param>
		/// <returns></returns>
		IPage ClickLinkInArea(string type, string linkText, string areaIdentifer);

		/// <summary>
		/// Click on a clickable UI control
		/// </summary>
		/// <param name="name"></param>
		/// <returns></returns>
		IPage ClickButton(string identifer);

		/// <summary>
		/// Type in a typable UI control
		/// </summary>
		/// <param name="name"></param>
		/// <param name="text"></param>
		/// <returns></returns>
		IPage Type(string identifer, string text);

		/// <summary>
		/// Choose by text from a dropdown like UI control
		/// </summary>
		IPage ChooseFromDropdown(string identifer, string text);

		/// <summary>
		/// Choose by text from checkbox
		/// Example scenario: Check 'male' in 'Gender group of checkboxes' 
		/// </summary>
		IPage ChooseFromCheckboxes(string areaIdentifer, string identifer, bool isChecked);


		/// <summary>
		/// Choose by text from textboxes
		/// Example scenario: Check 'male' in 'Gender group of radiobuttons' 
		/// </summary>
		IPage ChooseFromRadiobuttons(string areaIdentifer, string identifer);


		/// <summary>
		/// Example scenario: Can I see 'Medidata' in the 'Header area'?
		/// </summary>
		/// <param name="text"></param>
		/// <param name="areaIdentifer"></param>
		/// <returns></returns>
		bool CanSeeTextInArea(string text, string areaIdentifer);

		/// <summary>
		/// NavigateTo() is abstract compares to ClickLink(), which clicks on a concrete link text
		/// </summary>
		/// <param name="name"></param>
		/// <returns></returns>
		IPage NavigateTo(string identifer);

        /// <summary>
        /// uses the pages url and params to go to itself
        /// </summary>
        /// <returns></returns>
        IPage NavigateToSelf(NameValueCollection parameters = null);

		/// <summary>
		/// Is the page in browser the same page this object represents.
		/// </summary>
		/// <returns></returns>
		bool IsThePage();

		/// <summary>
		/// Get some critical text from the page
		/// 
		/// Example secnario: Get the artile's title from current page
		/// </summary>
		/// <param name="identifer"></param>
		string GetInfomation(string identifer);
	}
}
