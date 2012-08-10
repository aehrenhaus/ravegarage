using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	public interface ICanPaginate : IPage
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

		/// <summary>
		/// Because a page may have many area, a PO class implements ICanPaginate doesn't mean everything on page can be paginated.
		/// This method checks if a particular area on page can be paginated.
		/// </summary>
		/// <param name="areaIdentifer"></param>
		/// <returns></returns>
		bool CanPaginate(string areaIdentifer);
	}
}
