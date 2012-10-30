using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Threading;

namespace Medidata.RBT.PageObjects.Rave
{
    public class PDFCreationModel
    {
        public string Name { get; set; }
        public string Profile { get; set; }
        public string Study { get; set; }
        public string Role { get; set; }
        public string SiteGroup { get; set; }
        public string Site { get; set; }
        public string Subject { get; set; }
        public string Locale { get; set; }
        public string CRFVersion { get; set; }
    }

    public class FileRequestCreateDataRequestPage : RavePageBase
    {
        /// <summary>
        /// Create a new data pdf file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, UniqueName dictates the data PDF's name</param>
        /// <returns>A new FileRequestPage</returns>
        public FileRequestPage CreateDataPDF(PDFCreationModel args)
        {
            if (!string.IsNullOrEmpty(args.Name))
                Type("UniqueName", args.Name);
            if (!string.IsNullOrEmpty(args.Profile))
                ChooseFromDropdown("_ctl0_Content_FileRequestForm_ConfigProfileID", args.Profile);
            if (!string.IsNullOrEmpty(args.Study))
                ChooseFromDropdown("Study", args.Study);
            if (!string.IsNullOrEmpty(args.Locale))
                ChooseFromDropdown("Locale", args.Locale);
            if (!string.IsNullOrEmpty(args.Role))
            {
                var dlRole = Browser.FindElementById("Role");
                Thread.Sleep(1000);
                ChooseFromDropdown("Role", args.Role);
            }
            if (!string.IsNullOrEmpty(args.SiteGroup))
            {
                IWebElement div = Browser.TryFindElementById("SitesSitegroups");
				IWebElement span = Browser.WaitForElement(b => div.Spans().FirstOrDefault(x => x.Text == args.SiteGroup));

                span.Checkboxes()[0].EnhanceAs<Checkbox>().Check();
            }
            if (!string.IsNullOrEmpty(args.Site))
            {
                IWebElement expandSite = Browser.FindElementById("ISitesSitegroups_SG_1");
                if (expandSite.GetAttribute("src").Contains("plus"))
                    expandSite.Click();

                IWebElement div = Browser.TryFindElementById("DSitesSitegroups_SG_1");
				IWebElement span = Browser.WaitForElement(b => div.Spans().FirstOrDefault(x => x.Text == args.Site));
                span.Checkboxes()[0].EnhanceAs<Checkbox>().Check();
            }
            if (!string.IsNullOrEmpty(args.Subject))
            {
                IWebElement expandBtn = Browser.FindElementById("Subjects_ShowHideBtn");
                expandBtn.Click();

				IWebElement tr = Browser.WaitForElement(b => b.FindElements(By.XPath("//table[@id='Subjects_FrontEndCBList']/tbody/tr")).FirstOrDefault(x => x.Text == args.Subject));

                tr.Checkboxes()[0].Click();
            }


            ClickLink("Save");
            return new FileRequestPage();
        }

        public override string URL
        {
            get { return "Modules/PDF/FileRequest.aspx?Type=WithData"; }
        }
    }
}
