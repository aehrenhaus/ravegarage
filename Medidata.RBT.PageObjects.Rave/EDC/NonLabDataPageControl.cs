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
	public class NonLabDataPageControl:ControlBase, IEDCDataPageControl
	{
		public NonLabDataPageControl(IPage page)
			: base(page)
		{
			
		}


		//-------------STRUCTURE for noe-lab form
		//span id="_ctl0_Content_R"
		//    table 1 summary
		//    table 2 
		//        tr 1 class=breaker herader
		//        tr 2+
		//            td
		//                table class=evenWarning width=100%
		//                    tr
		//                        td 1 class="crf_rowLeftSide
		//                            tab;e
		//                                tr
		//                                    td crf_preText
		//                                        Message and <br> table
		//                        td 3 class=crf_rowRightSide

		//
		public IEDCFieldControl FindField(string fieldName)
		{
            
            var leftSideTds = TestContext.Browser.FindElements(By.XPath("//td[@class='crf_rowLeftSide']"));
			var area = leftSideTds.FirstOrDefault(x => 
				{
					return x.FindElement(By.XPath(".//td[@class='crf_preText']")).GetInnerHtml()
						.Split(new string[] { "\r\n", "<" }, StringSplitOptions.None)[0].Trim() == fieldName;
				});

            if (area == null)
                throw new Exception("Can't find field area:" + fieldName);
            var tds = area.Parent().Children();
            return new NonLabFieldControl(Page, area, tds[tds.Count - 1]);
        }

        public void FindFieldByText(string fieldText)
        {
            var el = TestContext.Browser.FindElementById("_ctl0_Content_R");
           
        }
	}
}
