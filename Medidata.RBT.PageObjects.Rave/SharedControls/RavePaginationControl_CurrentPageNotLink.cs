using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave
{
	/// <summary>
	/// There are many kind of rave pagination controls, 
	/// This is just one implementation 
	/// </summary>
	public class RavePaginationControl_CurrentPageNotLink : AbstractPaginiationControl
	{
		private IWebElement container;

		public RavePaginationControl_CurrentPageNotLink(IPage parent, IWebElement container)
			: base(parent)
		{
			this.container = container;
		}

		public override int CurrentPageNumber
		{
			get
			{
				var span = container.TryFindElementByXPath(".//span | .//label");
				return int.Parse(span.Text) ;
			}
		}

		public override bool GoNextPage(string areaIdentifier)
		{
			if (container == null)
				return false;

			var pages = container.FindElements(By.TagName("a"));

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

			return false;
			
		}
	}
}
