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
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.PageObjects.Rave.TableModels.PDF;

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

            string saveLinkText = "Save";

            if (isLocalizationTest)
                saveLinkText = PrependLocalization(saveLinkText);

            ClickLink(saveLinkText);

            Browser.TryFindElementById("_ctl0_Content_SearchCriteriaLabel", true, 10);
            //To make sure saved pdf is avaialble in the list before we try to generate it
            this.Browser.Navigate().Refresh();

            return new FileRequestPage();
        }

        /// <summary>
        /// Perform specific PDF selections that are only viable for data PDF
        /// </summary>
        /// <param name="args">The PDF arguments you want to select</param>
        public override void PerformPDFSpecificSelections(PDFCreationModel args)
        {
            SelectSiteGroups(!string.IsNullOrEmpty(args.SiteGroups) ? args.SiteGroups.Split(',').ToList() : null);
            SelectSites(!string.IsNullOrEmpty(args.SiteGroups) ? args.Sites.Split(',').ToList() : null);
            SelectSubjects(!string.IsNullOrEmpty(args.SiteGroups) ? args.Subjects.Split(',').ToList() : null);
        }

        /// <summary>
        /// Select the site group from the checkbox span for pdf generator
        /// </summary>
        /// <param name="siteGroup"></param>
        public void SelectSiteGroups(List<string> siteGroups)
        {
            if (siteGroups != null)
            {
                foreach (string siteGroup in siteGroups)
                {
                    IWebElement div = Browser.TryFindElementById("SitesSitegroups");
                    IWebElement span = Browser.TryFindElementBy(b => div.Spans().FirstOrDefault(x => x.Text == SeedingContext.TryGetExistingFeatureObject<SiteGroup>(siteGroup).UniqueName));

                    span.Checkboxes()[0].EnhanceAs<Checkbox>().Check();
                }
            }
        }

        /// <summary>
        /// Select the site name form the dropdown checkboxes for pdf generator
        /// </summary>
        /// <param name="sName"></param>
        public void SelectSites(List<string> sites)
        {
            if (sites != null)
            {
                foreach (string site in sites)
                {
                    Site siteSeedingObject = SeedingContext.TryGetExistingFeatureObject<Site>(site);

                    int siteGroupID = siteSeedingObject.SiteGroup.ID;
                    IWebElement expandSite = Browser.FindElementById("ISitesSitegroups_SG_" + siteGroupID);
                    if (expandSite.GetAttribute("src").Contains("plus"))
                        expandSite.Click();

                    IWebElement div = Browser.FindElementById("DSitesSitegroups_SG_" + siteGroupID);

                    IWebElement span = Browser.TryFindElementBy(b => div.Spans().FirstOrDefault(x => x.Text == siteSeedingObject.UniqueName));
                    span.Checkboxes()[0].EnhanceAs<Checkbox>().Check();
                }
            }
        }

        /// <summary>
        /// Select the subject from the checkboxes for pdf generator
        /// </summary>
        /// <param name="subject"></param>
        public void SelectSubjects(List<string> subjects)
        {
            if (subjects != null)
            {
                foreach (string subject in subjects)
                {

                    IWebElement expandBtn = Browser.FindElementById("Subjects_ShowHideBtn");
                    expandBtn.Click();

                    IWebElement tr = Browser.TryFindElementBy(b => b.FindElements(By.XPath("//table[@id='Subjects_FrontEndCBList']/tbody/tr"))
                        .FirstOrDefault(x => x.Text == subject));

                    tr.Checkboxes()[0].Click();
                }
            }
        }

        public override string URL
        {
            get { return "Modules/PDF/FileRequest.aspx?Type=WithData"; }
        }
    }
}
