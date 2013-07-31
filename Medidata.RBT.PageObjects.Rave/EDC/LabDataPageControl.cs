using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.EDC;
using Medidata.RBT.SharedObjects;
using System.Text.RegularExpressions;

namespace Medidata.RBT.PageObjects.Rave
{
    public class LabDataPageControl : DataPageControl, IControl
	{
		public LabDataPageControl(IPage page)
			: base(page)
		{
		}

        public IEDCFieldControl FindUnitDropdown(string fieldText)
        {
            IWebElement el = Page.Browser.FindElements(By.XPath("//span[contains(@id,'Content_R')]")).FirstOrDefault();
            var area = el.FindElementsByText<IWebElement>(fieldText).FirstOrDefault();

            if (area == null)
                throw new Exception("Can't find field area:" + fieldText);
            var tds = area.Parent().Children();
            return new LabFieldControl(Page, area, fieldText);
        }
	}
}
