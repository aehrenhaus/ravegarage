using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.SeleniumExtension
{
	public class RadioButton :EnhancedElement
	{
		public void Set()
		{
			this.Click();
		}

	}
}
