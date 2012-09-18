using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.UI;
using OpenQA.Selenium;

namespace Medidata.RBT.SeleniumExtension
{
	public class Dropdown :EnhancedElement
	{
		public void SelectByText(string text)
		{
			new SelectElement(this).SelectByText(text); 
		}

        public void SelectByPartialText(string text)
        {
            IWebElement optionElement = this.FindElement(By.XPath("option[contains(., '" + text + "')]"));
            optionElement.EnhanceAs<Option>().Select();
        }

		public void SelectByValue(string val)
		{
			new SelectElement(this).SelectByValue(val);
		}
	}
}
