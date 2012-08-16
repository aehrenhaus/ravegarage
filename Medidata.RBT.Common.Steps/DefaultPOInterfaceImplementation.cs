﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT
{

	public static class DefaultPOInterfaceImplementation
	{
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
			try{
				do
				{
					foundOnPage++;
					found = searchFunc();
					if (found != null)
						break;

				}
				while (page.GoNextPage(areaIdentifier));
			}
			catch{
			}

			return found;
		
		}

		public static bool VerifyTableRowsExist_Default(this ICanVerifyExist page, string tableIdentifier, Table matchTable)
		{
			ICanPaginate ppage = page as ICanPaginate;
			ICanHighlight hpage = page as ICanHighlight;
			int totalMatchCount = 0;

			//defines  the Func that searchs the current page.
			Func<IWebElement> searchOnPage = () =>
			{
				HtmlTable htmlTable = page.GetElementByName(tableIdentifier).EnhanceAs<HtmlTable>();
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
					TestContext.TrySaveScreenShot();
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

		public static bool VerifyTableColumnInAphabeticalOrder_Default(ICanVerifyInOrder page, string tableIdentifier, string column)
		{
			throw new NotImplementedException();
		}

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
