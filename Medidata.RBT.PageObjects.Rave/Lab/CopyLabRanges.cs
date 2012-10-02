using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
namespace Medidata.RBT.PageObjects.Rave
{
    public class CopyLabRanges : LabPageBase
    {

        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/CopyLabRanges.aspx";
            }
        }

        /// <summary>
        /// Copies the lab range.
        /// </summary>
        /// <param name="labType">Type of the lab.</param>
        public void CopyLabRange(string labType)
        {
            //var elms=  Browser.RadioButtons("_rblOptions");
            //Browser.RadioButtons().FirstOrDefault(rb => rb.Text.Contains("Alert Lab"));
            //var el = Browser.RadioButton("_rblOptions", true);
            //el.SendKeys(labType);

            Browser.RadioButtons().FirstOrDefault(rb => rb.Parent().Children()[1].Text == labType).Set();

            IWebElement pdfTr = FindLab(labType);
            pdfTr.TryFindElementByPartialID("_ImgBtnSelect").Click();
            Browser.TryFindElementByPartialID("_ImgBtnCopy").Click();
        }


         /// <summary>
        /// Finds the lab.
        /// </summary>
        /// <param name="labType">Type of Lab</param>
        /// <returns></returns>
        public IWebElement FindLab(string type)
        {
            Table dt = new Table("Lab Type");
            dt.AddRow(type);

            HtmlTable table = Browser.TryFindElementByPartialID("_SiteLabsGrid").EnhanceAs<HtmlTable>();
            IWebElement pdfTr =  table.FindMatchRows(dt).FirstOrDefault();          
            return pdfTr;
        }

    }
}
