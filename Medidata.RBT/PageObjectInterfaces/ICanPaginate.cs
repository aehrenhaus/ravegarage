using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	public interface ICanPaginate
	{
		int CurrentPageNumber { get; }

		/// <summary>
		/// Returns true if find and goes to next page
		/// </summary>
		bool GoNextPage(string areaIdentifier);

		/// <summary>
		/// Returns true if find and goes to previous page
		/// </summary>
		bool GoPreviousPage(string areaIdentifier);

		/// <summary>
		/// Returns true if find and goes to page X
		/// </summary>
		bool GoToPage(string areaIdentifier, int page);

		/// <summary>
		/// Because a page may have many area, a PO class implements ICanPaginate doesn't mean everything on page can be paginated.
		/// This method checks if a particular area on page can be paginated.
		/// </summary>
		/// <param name="areaIdentifier"></param>
		/// <returns></returns>
		bool CanPaginate(string areaIdentifier);
	}
}
