using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using System.IO;
using System.Xml;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific CrfVersion. It is seedable.
    ///These are not uploaded, and are created entirely through the UI.
    ///</summary>
    public class CrfVersion : SeedableObject
    {
        public UploadedDraft UploadedDraft { get; set; } //The draft that is uploaded to create this CRFVersion

        /// <summary>
        /// The CrfVersion constructor
        /// </summary>
        /// <param name="draftName">The draft that is uploaded to create this CRFVersion</param>
        /// <param name="crfVersionName">The feature defined name of this Crf Version</param>
        /// <param name="seed">Bool determining whether you want to seed the object if it is not in the FeatureObjects dictionary</param>
        public CrfVersion(string draftName, string crfVersionName, bool seed = false)
            : base(crfVersionName)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = crfVersionName;
                FeatureObject draftObject;
                TestContext.FeatureObjects.TryGetValue(draftName, out draftObject);
                UploadedDraft = (UploadedDraft)draftObject;

                if (seed)
                    Seed();
            }
        }

        /// <summary>
        /// Navigate to the ArchitectCRFDraft page for the UploadedDraft that creates this crfVersion
        /// </summary>
        public override void NavigateToSeedPage()
        {
            LoginPage.LoginUsingDefaultUserFromAnyPage();
            TestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(UploadedDraft.Project.UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().ClickDraft(UploadedDraft.Draft.Name);
        }

        /// <summary>
        /// Publish this CRF version
        /// </summary>
        public override void CreateObject()
        {
            TestContext.CurrentPage.As<ArchitectCRFDraftPage>().PublishCRF(UniqueName);
            TestContext.FeatureObjects.Add(Name, this);
            new ArchitectPage().ClickProject(UploadedDraft.Project.UniqueName);
        }

        /// <summary>
        /// Make the UniqueName of this CRFVersion by appending a TID on to the end of Name
        /// </summary>
        public override void MakeUnique()
        {
            UniqueName = Name + TID;
        }
    }
}
