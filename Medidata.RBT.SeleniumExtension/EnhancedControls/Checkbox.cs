using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT.SeleniumExtension
{
	public class Checkbox :EnhancedElement
	{
		public Checkbox()
		{
		}

		public Checkbox(IWebElement ele)
			: base(ele)
		{
		}

		public bool Checked
		{
			get
			{
				return Element.GetAttribute("checked") == "true";
			}
		}

		public void Check()
		{
            if (!this.Selected)
                this.Click();
		}

		public void Uncheck()
		{
            if (this.Selected)
                this.Click();
		}

		public void Toggle()
		{
			this.Click();
		}
	}
}
