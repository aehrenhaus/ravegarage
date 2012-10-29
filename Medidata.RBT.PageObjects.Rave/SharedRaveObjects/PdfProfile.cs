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
    public class PdfProfile : SeedableObject
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="profileName"></param>
        /// <param name="seed"></param>
        public PdfProfile(string profileName, bool seed = false)
            :base(profileName)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = profileName;

                if (seed)
                    Seed();
            }
        }
        /// <summary>
        /// 
        /// </summary>
        public override void NavigateToSeedPage()
        {
            LoginPage.LoginUsingDefaultUserFromAnyPage();
            TestContext.CurrentPage.As<HomePage>().ClickLink("Configuration");
            TestContext.CurrentPage.As<ConfigurationPage>().ClickLink("PDF Settings");
        }
        /// <summary>
        /// Create a unique name for the pdf profile by appending a TID.
        /// </summary>
        public override void MakeUnique()
        {
            UniqueName = Name + TID;
        }
        /// <summary>
        /// 
        /// </summary>
        public override void CreateObject()
        {
            TestContext.CurrentPage.As<PDFConfigProfilesPage>().CreateNewPdfProfile(UniqueName);
        }
    }
}
