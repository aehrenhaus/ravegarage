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
		WebTestContext Context { get; set; }

		/// <summary>
		/// The browser driver. Represents the browser
		/// </summary>
		RemoteWebDriver Browser { get; }

		/// <summary>
		/// SearchContext, 
		/// operations on the page should be restricted in SearchContext , not Browser,
		/// although it's more likely in most cases SearchContext is the Browser.
		/// 
		/// </summary>
		ISearchContext SearchContext { get; set; }

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
		///		.As<UserAdministrationPage>()
		///		.SearchUser("user1")
		///		.Choose("something")
		///		.As<UserAdministrationPage>()
		///		.ChooseUserFromResult("user1")
		/// </code>
		/// </summary>
		TPage As<TPage>() where TPage : class;

		/// <summary>
		/// The absolute path (after the BaseURL part) that represents the page.
		/// Example: "Modules/AmendmentManager/MigrationResults.aspx"
		/// 
		/// URL property is not the actual url in the browser. 
		/// But is a fix and UNIQUE value of POClass that used in comparison and navigtion
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
		/// I click "Study" link "xxxStudy" in "header"
		/// </summary>
		/// <param name="linkText"></param>
		/// <param name="objectType"></param>
		/// <param name="areaIdentifier"></param>
		/// <returns></returns>
		IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null, bool partial = false);

		/// <summary>
		/// Click on a clickable UI control
		/// </summary>
		IPage ClickButton(string identifier);

        /// <summary>
        /// Press a key on the keyboard
        /// </summary>
        void PressKey(string key);
		
		/// <summary>
		/// Type in a typable UI control
		/// </summary>
		IPage Type(string identifier, string text);

		/// <summary>
		/// Choose by text from a dropdown like UI control
		/// </summary>
		IPage ChooseFromDropdown(string identifier,string text, string objectType = null, string areaIdentifier = null);

		/// <summary>
		/// Choose by text from checkbox
		/// Example scenario: Check 'male' in 'Gender group of checkboxes' 
		/// </summary>
		IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null);

		/// <summary>
		/// Choose by text from textboxes
		/// Example scenario: Check 'male' in 'Gender group of radiobuttons' 
		/// </summary>
		IPage ChooseFromRadiobuttons(string areaIdentifier, string identifier);


		/// <summary>
		/// NavigateTo() is abstract compares to ClickLink() which clicks on a concrete link text
		/// </summary>
		IPage NavigateTo(string identifier);

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
		/// Get useful infomation from page.
		/// 
		/// Example:
		/// Get page's title
		/// Get the CRF version displayed on the bottom of the page
		/// Get how many items are in the list
		/// 
		/// What the 'information' is is depend on the page implementation, 
		/// it does not necessarily be some text on the page.
		/// 
		/// </summary>
		/// <param name="identifier"></param>
		string GetInfomation(string identifier);

		/// <summary>
		/// Set element to obain focus
		/// </summary>
        void SetFocusElement(IWebElement id);

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
        IWebElement GetFocusElement();


		/// <summary>
		/// This method is used by many default implmentation of IPage methods, where a friendly name is used to find a IWebElement
		/// In many case you will only need to orverride this method to provide mappings on your specific page object in order for a step to work.
		/// </summary>
		IWebElement GetElementByName(string identifier, string areaIdentifier= null, string listItemIdentifier = null);

		IWebElement TryGetElementByName(string identifier, string areaIdentifier = null, string listItemIdentifier = null);
	}
}
