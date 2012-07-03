using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Specialized;

namespace Medidata.RBT
{
	public interface IPage
	{
		/// <summary>
		/// Cast current object to a child type, just to support stream lined code style
		/// Example:
		/// CurrentPage is a IPage
		/// Without the As() method, code would be
		/// <code>
		/// ((CurrentPage as UserAdministrationPage).SearchUser("user1").Choose("something") as UserAdministrationPage).ChooseUserFromResult("user1")
		/// </code>
		/// With the As() method, code can be more streamlined:
		/// 
		/// <example>
		/// CurrentPage.As< UserAdministrationPage>().SearchUser("user1").Choose("something").As<UserAdministrationPage>().ChooseUserFromResult("user1")
		/// </example>
		/// </summary>
		TPage As<TPage>() where TPage : class, IPage;

		/// <summary>
		/// Current Url
		/// </summary>
		string URL { get; }

        string BaseURL { get; }

		/// <summary>
		/// Click a link in all page area.
		/// There is no way to know what page is next page. 
		/// So when clicking a link causes a change of URL, use ClickLinkInArea() method. 
		/// See more details on summary of ClickLinkInArea()
		/// </summary>
		/// <param name="linkText"></param>
		/// <returns></returns>
		IPage ClickLink(string linkText);

		/// <summary>
		/// Click a hyperlink in a certen area.
		/// areaIdentifer not only points out the area, but also implies what is the target page type.
		/// This is very useful for a system that adopts page object design pattern.
		/// </summary>
		/// <param name="linkText"></param>
		/// <param name="areaIdentifer"></param>
		/// <returns></returns>
		IPage ClickLinkInArea(string type, string linkText, string areaIdentifer);

		/// <summary>
		/// Click on a clickable control(button and more).
		/// </summary>
		/// <param name="name"></param>
		/// <returns></returns>
		IPage ClickButton(string identifer);

		/// <summary>
		/// Type in a typable control( text box and more)
		/// </summary>
		/// <param name="name"></param>
		/// <param name="text"></param>
		/// <returns></returns>
		IPage Type(string identifer, string text);

		/// <summary>
		/// Choose by text from dropdown
		/// </summary>
		IPage ChooseFromDropdown(string identifer, string text);

		/// <summary>
		/// Choose by text from checkbox
		/// groupName can be ignored depends on the implementaion
		/// </summary>
		IPage ChooseFromCheckboxes(string areaIdentifer, string identifer, bool isChecked);


		/// <summary>
		/// Choose by text from textboxes
		/// groupName can be ignored depends on the implementaion
		/// </summary>
		IPage ChooseFromRadiobuttons(string areaIdentifer, string identifer);



		bool CanSeeTextInArea(string text, string areaIdentifer);

		/// <summary>
		/// NavigateTo() is abstract while ClickLink() clicks concrete link text
		/// </summary>
		/// <param name="name"></param>
		/// <returns></returns>
		IPage NavigateTo(string identifer);

        /// <summary>
        /// uses the pages url and params to go to itself
        /// </summary>
        /// <returns></returns>
        IPage NavigateToSelf();

		/// <summary>
		/// Is the page in browser the same page this object represents.
		/// This method can use URL property to verify, but can verify more than that.
		/// </summary>
		/// <returns></returns>
		bool IsThePage();
	}
}
