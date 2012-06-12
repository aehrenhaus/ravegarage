using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

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

		/// <summary>
		/// Click on a clickable control.
		/// </summary>
		/// <param name="name"></param>
		/// <returns></returns>
		IPage Click(string name);

		/// <summary>
		/// Type in a typable control( text box and more)
		/// </summary>
		/// <param name="name"></param>
		/// <param name="text"></param>
		/// <returns></returns>
		IPage Type(string name, string text);

		/// <summary>
		/// Choose by text from a choosable control( dropdown list and more)
		/// </summary>
		/// <param name="name"></param>
		/// <param name="text"></param>
		/// <returns></returns>
		IPage Choose(string name, string text);

		/// <summary>
		/// Is the page in browser the same page this object represents.
		/// </summary>
		/// <returns></returns>
		bool IsThePage();
	}
}
