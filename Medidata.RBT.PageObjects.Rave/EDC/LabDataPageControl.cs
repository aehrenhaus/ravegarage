using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;

namespace Medidata.RBT.PageObjects.Rave
{
	public class LabDataPageControl:ControlBase, IEDCDataPageControl
	{
		public LabDataPageControl(IPage page)
			: base(page)
		{
			//set Element here
			//Element = TestContext.Browser.TryFindElementBy(
		}




		//-----------STRUCTURE Lab form:
		//span id="_ctl0_Content_R"
		//table 1 lab dropdown
		//table 2
		//   tr class="evenRow" width="100%
		//        td 2 Label
		//        td 4 
		//            table
		//                td 1 
		//                    input

		//        td 5 Range status
		//        td 6 Unit
		//        td 7 Range
		//        td 8
		//            table (pen and other action controls)
		//	tr(next to the above)
		//		td2
		//			table
		//				tr1
		//					td 2 Query message<br>....,cancel box
		//				tr2
		//					td2 answer <br> dropdown answer textbox
		//			table(other query)
		public IEDCFieldControl FindField(string fieldText)
		{
            IWebElement el = TestContext.Browser.FindElements(By.XPath("//span[contains(@id,'Content_R')]")).FirstOrDefault();
            var area = el.FindElementsByText<IWebElement>(fieldText).FirstOrDefault();

            var fieldTRs = el.FindElements(By.XPath("table[2]/tbody/tr"));
            int i = 0;

            for (; i < fieldTRs.Count; i++)
            {
                if (fieldTRs[i].Children()[1].Text == fieldText)
                    break;
            }
            IWebElement fieldTR = fieldTRs[i];
            IWebElement fieldTRQueries = fieldTRs[i + 1];

            return new LabFieldControl(Page, fieldTR.Children()[1], fieldTRQueries);

		}

        public IEDCFieldControl FindUnitDropdown(string fieldText)
        {
            IWebElement el = TestContext.Browser.FindElements(By.XPath("//span[contains(@id,'Content_R')]")).FirstOrDefault();
            var area = el.FindElementsByText<IWebElement>(fieldText).FirstOrDefault();

            if (area == null)
                throw new Exception("Can't find field area:" + fieldText);
            var tds = area.Parent().Children();
            return new LabFieldControl(Page, area, tds[tds.Count - 3]);

        }
	}
}
