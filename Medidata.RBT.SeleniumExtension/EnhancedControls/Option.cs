using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT.SeleniumExtension
{
	public class Option :EnhancedElement
	{
		public Option()
		{
		}

        public Option(IWebElement ele)
			: base(ele)
		{
		}

		public void Select()
		{
            if (!Selected)
                this.Click();
		}
	}
}
