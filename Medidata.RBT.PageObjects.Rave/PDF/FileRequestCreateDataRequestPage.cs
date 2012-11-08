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

            bool isLocalizationTest = false;
            if (!string.IsNullOrEmpty(args.Locale) && args.Locale == "LLocalization Test")
                isLocalizationTest = true;

            SelectSiteGroup(args.SiteGroup);
            SelectSite(args.Site);
            SelectSubject(args.Subject);

            string saveLinkText = "Save";

            if (isLocalizationTest)
                saveLinkText = PrependLocalization(saveLinkText);

            ClickLink(saveLinkText);
            return new FileRequestPage();
        }

        /// <summary>
        /// Select the site group from the checkbox span for pdf generator
        /// </summary>
        /// <param name="siteGroup"></param>
        public void SelectSiteGroup(string siteGroup)
        {
            if (!string.IsNullOrEmpty(siteGroup))
            {
                IWebElement div = Browser.TryFindElementById("SitesSitegroups");
                IWebElement span = Browser.WaitForElement(b => div.Spans().FirstOrDefault(x => x.Text == siteGroup));

                span.Checkboxes()[0].EnhanceAs<Checkbox>().Check();
            }
        }

        /// <summary>
        /// Select the site name form the dropdown checkboxes for pdf generator
        /// </summary>
        /// <param name="sName"></param>
        public void SelectSite(string sName)
        {
            if (!string.IsNullOrEmpty(sName))
            {
                IWebElement expandSite = Browser.FindElementById("ISitesSitegroups_SG_1");
                if (expandSite.GetAttribute("src").Contains("plus"))
                    expandSite.Click();

                IWebElement div = Browser.TryFindElementById("DSitesSitegroups_SG_1");

                string siteName = TestContext.GetExistingFeatureObjectOrMakeNew
                    (sName, () => new Site(sName)).UniqueName;

                IWebElement span = Browser.WaitForElement(b => div.Spans().FirstOrDefault(x => x.Text == siteName));
                span.Checkboxes()[0].EnhanceAs<Checkbox>().Check();
            }
        }

        /// <summary>
        /// Select the subject from the checkboxes for pdf generator
        /// </summary>
        /// <param name="subject"></param>
        public void SelectSubject(string subject)
        {
            if (!string.IsNullOrEmpty(subject))
            {
                IWebElement expandBtn = Browser.FindElementById("Subjects_ShowHideBtn");
                expandBtn.Click();

                IWebElement tr = Browser.WaitForElement(b => b.FindElements(By.XPath("//table[@id='Subjects_FrontEndCBList']/tbody/tr")).FirstOrDefault(x => x.Text == subject));

                tr.Checkboxes()[0].Click();
            }
        }

        public override string URL
        {
            get { return "Modules/PDF/FileRequest.aspx?Type=WithData"; }
        }
    }
}
