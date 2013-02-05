using System;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Linq;
using System.Collections;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to labs
    /// </summary>
    [Binding]
    public partial class LabSteps : BrowserStepsBase
    {
        /// <summary>
        /// XML config file is uploaded for seeding purposes.
        /// </summary>
        /// <param name="configName">The name of lab configuration to be loaded (seeded)</param>
        [StepDefinition(@"xml Lab Configuration ""([^""]*)"" is uploaded")]
        public void XmlDraft____IsUploaded(string configName)
        {
            SeedingContext.GetExistingFeatureObjectOrMakeNew(configName, () => new LabConfiguration(configName));
        }

        /// <summary>
        /// XML config file is uploaded while maintaining the length of the strings of some of the lab configuration's uploaded items.
        /// </summary>
        /// <param name="configName">The name of lab configuration to be loaded (seeded)</param>
        [StepDefinition(@"xml Lab Configuration ""([^""]*)"" is uploaded maintaining length")]
        public void XmlLabConfiguration____IsUploadedMaintainingLength(string configName)
        {
            SeedingContext.GetExistingFeatureObjectOrMakeNew(configName, () => new LabConfiguration(configName, true));
        }

        /// <summary>
        /// XML config file is uploaded while maintaining the length of the strings of some of the lab configuration's uploaded items.
        /// It also stays on the page after upload. So that errors may be verified.
        /// </summary>
        /// <param name="configName">The name of lab configuration to be loaded (seeded)</param>
        [StepDefinition(@"xml Lab Configuration ""([^""]*)"" is uploaded maintaining length and staying on page")]
        public void XmlLabConfiguration____IsUploadedMaintainingLengthAndStayingOnPage(string configName)
        {
            SeedingContext.GetExistingFeatureObjectOrMakeNew(configName, () => new LabConfiguration(configName, true, false));
        }

        /// <summary>
        /// Select ranges for lab
        /// </summary>
        /// <param name="labName">Name of the lab.</param>
        /// <param name="labType">Type of the lab.</param>
        [StepDefinition(@"I select Ranges for ""([^""]*)"" for ""([^""]*)"" lab")]
        public void ISelectRangesFor__(string labName, string labType)
        {
            labName =  SpecialStringHelper.Replace(labName);

			var currentPage = WebTestContext.CurrentPage.As<LabPageBase>();
            var currentRow = currentPage.FindLab(labName, labType);
            currentPage.SelectLabRange(currentRow);
        }

        /// <summary>
        /// Is the select add new range.
        /// </summary>
        [StepDefinition(@"I select ""Add New Range""")]
        public void ISelectAddNewRange()
        {
            WebTestContext.CurrentPage.ClickLink("Add New Range");
        }

        /// <summary>
        /// Create lab.
        /// </summary>
        /// <param name="table">The table.</param>
        [StepDefinition(@"I create lab")]
        public void ICreateLab__(Table table)
        {
            SpecialStringHelper.ReplaceTableColumn(table, "Name");
            LabModel lab = table.CreateInstance<LabModel>();
            CurrentPage.As<LabPageBase>().AddNewLab(lab.Name, lab.Type, lab.RangeType);
        }


        /// <summary>
        /// Create range.
        /// </summary>
        /// <param name="table">The table.</param>
        [StepDefinition(@"I create range")]
        public void ICreateRange__(Table table)
        {
            IEnumerable analyteRanges = table.CreateSet<AnalyteRangeModel>();
            foreach (AnalyteRangeModel analyteRange in analyteRanges)
                CurrentPage.As<LabRangesPage>().AddNewAnalyteRange(analyteRange);
           
        }

        /// <summary>
        /// Copy ranges for lab
        /// </summary>
        /// <param name="link">The link.</param>
        /// <param name="labType">Type of the lab.</param>
        [StepDefinition(@"I select ""([^""]*)"" form ""([^""]*)""")]
        public void ISelect__form__(string link, string labType)
        {
            WebTestContext.CurrentPage.ClickLink(link);
            CurrentPage.As<CopyLabRanges>().CopyLabRange(labType);
        }

        /// <summary>
        /// Add a new analyte to a lab
        /// </summary>
        /// <param name="analyte">Analyte to add as new version</param>
        [StepDefinition(@"I select ""New Version"" for ""([^""]*)"" lab")]
        public void ISelect__For__Lab(string analyte)
        {
            CurrentPage.As<LabRangesPage>().AddNewVersion(analyte);
        }
    }
}
