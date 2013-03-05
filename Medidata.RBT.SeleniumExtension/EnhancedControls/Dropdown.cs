using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.UI;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.SeleniumExtension
{
	public class Dropdown :EnhancedElement
	{
		public void SelectByText(string text)
		{
			new SelectElement(this).SelectByText(text); 
		}

        /// <summary>
        /// Verify dropbox contains an option by text
        /// </summary>
        /// <param name="text">The text to verify</param>
        /// <returns>Returns true if the text exists in the dropdown, otherwise returns false</returns>
        public bool VerifyByText(string text)
        {
            return (this.TryFindElementBy(By.XPath("option[contains(., '" + text + "')]")) != null);
        }

		public string SelectedText
		{
			get
			{
				return new SelectElement(this).SelectedOption.Text;
			}
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
