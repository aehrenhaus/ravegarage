using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
    /// <summary>
    /// Methods to verify table order
    /// </summary>
	public static class DefaultPOInterfaceImplementation
	{
        /// <summary>
        /// Find an element in a paginated list
        /// </summary>
        /// <param name="page"></param>
        /// <param name="areaIdentifier"></param>
        /// <param name="searchFunc"></param>
        /// <param name="foundOnPage"></param>
        /// <returns></returns>
		public static IWebElement FindInPaginatedList(this IHavePaginationControl page, string areaIdentifier, Func<IWebElement> searchFunc, out int foundOnPage)
		{
			ICanPaginate pager = null;

			IWebElement found = null;
			foundOnPage = 0;
			try
			{
				do
				{
					foundOnPage++;
					found = searchFunc();
					if (found != null)
						break;
					pager = page.GetPaginationControl(areaIdentifier);
				}
				while (pager.GoNextPage(areaIdentifier));
			}
			catch
			{
			}

			return found;

		}

		/// <summary>
		/// Extend ICanPaginate, use a passed in Func to find the element on each page.
		/// The search will stop till the Func returns IWebElement
		/// </summary>
		/// <param name="page"></param>
		/// <param name="areaIdentifier"></param>
		/// <param name="searchFunc"></param>
		/// <param name="foundOnPage"></param>
		/// <returns></returns>
		public static IWebElement FindInPaginatedList(this ICanPaginate page, string areaIdentifier, Func<IWebElement> searchFunc, out int foundOnPage)
		{
			IWebElement found = null;
			foundOnPage = 0;
			do
			{
				foundOnPage++;
				found = searchFunc();
				if (found != null)
					break;

			}
			while (page.GoNextPage(areaIdentifier));

			return found;
		
		}

        /// <summary>
        /// Verify that the table rows exist in the specified table
        /// </summary>
        /// <param name="page">The current page</param>
        /// <param name="tableIdentifier">The table to check</param>
        /// <param name="matchTable">Verification that table rows exist</param>
        /// <returns>True if the rows match those passed in, false if they don't</returns>
		public static bool VerifyTableRowsExist_Default(this IVerifyRowsExist page, string tableIdentifier, Table matchTable)
		{
			ICanPaginate ppage = page as ICanPaginate;
			ICanHighlight hpage = page as ICanHighlight;
			int totalMatchCount = 0;

			//defines the Func that searchs the current page.
			Func<IWebElement> searchOnPage = () =>
			{
				HtmlTable htmlTable = (page as IPage).GetElementByName(tableIdentifier).EnhanceAs<HtmlTable>();
				var matchTRs = htmlTable.FindMatchRows(matchTable);
				totalMatchCount += matchTRs.Count;

				//heightlight the found if supported
				foreach (var tr in matchTRs)
				{

					if (hpage != null)
						hpage.Hightlight("match tr", tr);
				}

				//if found , take a screenshot
				if (matchTRs.Count != 0)
				{
					SpecflowStaticBindings.Current.TrySaveScreenShot();
				}
                if (matchTRs.Count > 0)
                {
                    return matchTRs[0];
                }
				return null;
			};

			//if supports pagination , then go through all pages. If not, just do once on current page
			int pageNum;
			if (ppage != null && ppage.CanPaginate(tableIdentifier))
			{
				ppage.FindInPaginatedList(tableIdentifier, searchOnPage, out pageNum);
			}
			else
			{
				searchOnPage();
			}

			return totalMatchCount == matchTable.RowCount;
		}

        /// <summary>
        /// Unimplemented method
        /// </summary>
        /// <param name="page"></param>
        /// <param name="tableIdentifier"></param>
        /// <param name="column"></param>
        /// <returns></returns>
		public static bool VerifyTableColumnInAphabeticalOrder_Default(ICanVerifyInOrder page, string tableIdentifier, string column)
		{
			throw new NotImplementedException();
		}

        /// <summary>
        /// Verify the table is in alphabetical order
        /// </summary>
        /// <param name="page">The current page</param>
        /// <param name="tableIdentifier">The table to verify</param>
        /// <param name="hasHeader">If the table has a header</param>
        /// <param name="asc">Ascending or descending alphabetical order</param>
        /// <returns>True if the table is in alphabetical order, false if it is not</returns>
		public static bool VerifyTableInAphabeticalOrder_Default(ICanVerifyInOrder page, string tableIdentifier, bool hasHeader, bool asc)
		{
			HtmlTable htmlTable = page.GetElementByName(tableIdentifier).EnhanceAs<HtmlTable>();
			var trs = htmlTable.Rows();
			List<string> list = new List<string>();

			for (int i = hasHeader ? 1 : 0; i < trs.Count; i++)
			{
				list.Add(trs[i].Text.Trim());
			}

			IEnumerable<string> orderedList = list.OrderBy(x => x);
			if (!asc)
			{
				orderedList = orderedList.OrderByDescending(x => x);
			}
			orderedList = orderedList.ToList();
		
			bool inSameOrder = true;

			orderedList.Zip(list, (a, b) =>
				{
					if (a != b)
						inSameOrder = false;

					return default(string);

				}).ToArray();


			return inSameOrder;
		}
	}
}
