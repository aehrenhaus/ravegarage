using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class DCFQueriesPage : RavePageBase
	{
		public override IPage ChooseFromDropdown(string name, string text)
		{
			return base.ChooseFromDropdown(name, text);
		}


		protected override IWebElement GetElementByName(string name)
		{

			NameValueCollection mapping = new NameValueCollection();
			mapping["Advanced Search"] = "_ctl0_Content_lbtnAdvSearch";

			IWebElement ele = Browser.TryFindElementById(mapping[name]);
			if (ele == null)
			{
				throw new Exception("Can't find element: " + name);
			}

			return ele;
		}

	}
}
