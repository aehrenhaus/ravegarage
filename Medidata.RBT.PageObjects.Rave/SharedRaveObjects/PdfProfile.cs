using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.SiteAdministration;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.PageObjects.Rave.PDF;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// 
    /// </summary>
    public class PdfProfile : BaseRaveSeedableObject
    {
        /// <summary>
        /// Contructor for pdf profile object
        /// </summary>
        /// <param name="profileName">Name by which new pdf profile should be created</param>
        public PdfProfile(string profileName)
        {
            UniqueName = profileName;
        }
        /// <summary>
        /// Navigate to the "PDF Settings" page
        /// </summary>
        protected override void NavigateToSeedPage()
        {
            TestContext.CurrentPage.As<HomePage>().ClickLink("Configuration");
            TestContext.CurrentPage.As<WorkflowConfigPage>().ClickLink("PDF Settings");
        }
        /// <summary>
        /// Create a unique name for the pdf profile by appending a TID.
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }
        /// <summary>
        /// Created the new pdf profile using the UniqueName
        /// </summary>
        protected override void CreateObject()
        {
            TestContext.CurrentPage.As<PDFConfigProfilesPage>().CreateNewPdfProfile(UniqueName);
        }
    }
}
