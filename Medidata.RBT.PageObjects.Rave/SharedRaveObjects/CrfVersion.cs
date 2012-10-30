﻿using System;
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
    public class CrfVersion : BaseRaveSeedableObject
    {
		public UploadedDraft UploadedDraft
		{
			get
			{
				return TestContext.GetExistingFeatureObjectOrMakeNew<UploadedDraft>(DraftName, () => new UploadedDraft(DraftName));
			}
		} //The draft that is uploaded to create this CRFVersion

        /// <summary>
        /// The CrfVersion constructor
        /// </summary>
        /// <param name="draftName">The draft that is uploaded to create this CRFVersion</param>
        /// <param name="crfVersionName">The feature defined name of this Crf Version</param>
        public CrfVersion(string draftName, string crfVersionName)
        {
                UniqueName = crfVersionName;
				UniqueName = UniqueName+TID;
			this.DraftName = draftName;
        }

	    public string DraftName { get; set; }

	    /// <summary>
        /// Navigate to the ArchitectCRFDraft page for the UploadedDraft that creates this crfVersion
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            TestContext.CurrentPage.As<HomePage>().ClickLink("Architect");
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(UploadedDraft.Project.UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().ClickDraft(UploadedDraft.Draft.UniqueName);
        }

        /// <summary>
        /// Publish this CRF version
        /// </summary>
		protected override void CreateObject()
        {
            TestContext.CurrentPage.As<ArchitectCRFDraftPage>().PublishCRF(UniqueName);
            new ArchitectPage().ClickProject(UploadedDraft.Project.UniqueName);
        }

		
    }
}
