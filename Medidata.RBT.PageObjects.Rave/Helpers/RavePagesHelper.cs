using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	/// <summary>
	/// WARNING: Do not put page related static methods in here unless no where else to put. Try OO ways first.
	///
	/// </summary>
	static class RavePagesHelper
	{
		public static IWebElement FindInPaginatedList(this ICanPaginate page, string areaIdentifer, Func<IWebElement> searchFunc, out int foundOnPage)
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
				while (page.GoNextPage(areaIdentifer));
			}
			catch{
			}

			return found;
		
		}
	}
}
