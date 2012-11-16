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
	public class RavePaginationControl_Arrow : AbstractPaginiationControl
	{
		private IWebElement container;

		public RavePaginationControl_Arrow(IPage parent, IWebElement container)
			: base(parent)
		{
			this.container = container;
		}

		public override bool GoNextPage(string areaIdentifier)
		{
			if (container == null)
				return false;

			var link = container.TryFindElementById("_ctl0_Content_ListDisplayNavigation_LnkBtnNext");

			var disabled = link.GetAttribute("disabled");
			if (disabled == "true")
			{
				return false;
			}
			else
			{
				link.Click();
			}

			return true;
		}
	}
}
