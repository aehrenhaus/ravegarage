using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave
{
	/// <summary>
	/// Rave pagination to control if paging is done using divs
	/// </summary>
	public class DivPaginationControl : AbstractPaginiationControl
	{
		private IWebElement container;

        public DivPaginationControl(IPage parent, IWebElement container)
			: base(parent)
		{
			this.container = container;
		}

		public override int CurrentPageNumber
		{
			get
			{
                IWebElement div = container.TryFindElementBy(By.XPath(".//div[contains(@style, 'black') and contains(@id,'PageLink')]"));
                return int.Parse(div.Text);
			}
		}

		public override bool GoNextPage(string areaIdentifier)
		{
			if (container == null)
				return false;

            var pages = container.FindElements(By.XPath(".//div[contains(@style, 'block') and contains(@id,'PageLink')]"));

			if(pages.Count==0)
				return false;

			var nextNumber = CurrentPageNumber+1;
			var nextLink = pages.FirstOrDefault(x =>
			{
				int pageNum = 0;
				bool succeed = int.TryParse(x.Text, out pageNum);
				if (succeed && pageNum == nextNumber)
					return true;
				return false;
			});

			//if nextLink is null, see is there is the right side ... link
			if (nextLink == null)
			{
				var last = pages.Last();
				if (last.Text == "...")
				{
					last.Click();
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				nextLink.Click();
				return true ;
			}		
		}
	}
}
