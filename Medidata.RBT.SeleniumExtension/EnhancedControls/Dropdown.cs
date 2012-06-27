using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.SeleniumExtension
{
	public class Dropdown :EnhancedElement
	{
		public void SelectByText(string text)
		{
			new SelectElement(this).SelectByText(text); 
		}



		public void SelectByValue(string val)
		{
			new SelectElement(this).SelectByValue(val);
		}
	}
}
