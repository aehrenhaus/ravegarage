using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	public interface IPaginatedPage : IPage
	{
		/// <summary>
		/// Returns true if find and goes to next page
		/// </summary>
		bool GoNextPage(string areaIdentifer);

		/// <summary>
		/// Returns true if find and goes to previous page
		/// </summary>
		bool GoPreviousPage(string areaIdentifer);

		/// <summary>
		/// Returns true if find and goes to page X
		/// </summary>
		bool GoToPage(string areaIdentifer, int page);


	}
}
