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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave
{

    public class FileRequestCreateDataRequestPage : FileRequestCreateRequestPageBase
    {
        /// <summary>
        /// Create a new data pdf file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, Name dictates the data PDF's name</param>
        /// <returns>A new FileRequestPage</returns>
        public FileRequestPage CreateDataPDF(PDFCreationModel args)
        {
            base.CreatePDF(args);

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

                string siteName = TestContext.GetExistingFeatureObjectOrMakeNew
                    (args.Site, () => new Site(args.Site)).UniqueName;

                IWebElement span = Browser.WaitForElement(b => div.Spans().FirstOrDefault(x => x.Text == siteName));
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
