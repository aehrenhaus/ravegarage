using System;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Linq;

namespace Medidata.RBT.Features.Rave
{
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
            TestContext.GetExistingFeatureObjectOrMakeNew(configName, () => new LabConfiguration(configName, true));
        }

        /// <summary>
        /// Select ranges for lab
        /// </summary>
        /// <param name="labName">Name of the lab.</param>
        [StepDefinition(@"I select Ranges for ""([^""]*)"" for ""([^""]*)"" lab")]
        public void ISelectRangesFor__(string labName, string labType)
        {
            labName =  SpecialStringHelper.Replace(labName);

            var currentPage = TestContext.CurrentPage.As<LabRangesPage>();
            var currentRow = currentPage.FindLab(labName, labType);
            currentPage.SelectLabRange(currentRow);

        }

        /// <summary>
        /// Is the select add new range.
        /// </summary>
        [StepDefinition(@"I select ""Add New Range""")]
        public void ISelectAddNewRange()
        {
            TestContext.CurrentPage.ClickLink("Add New Range");
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
            CurrentPage.As<LabRangesPage>().AddNewAnalyteRange(table.CreateInstance<AnalyteRangeModel>());
        }

          /// <summary>
          /// Copy ranges for lab
          /// </summary>
          /// <param name="link">The link.</param>
          /// <param name="labType">Type of the lab.</param>
        [StepDefinition(@"I select ""([^""]*)"" form ""([^""]*)""")]
        public void ISelect__form__(string link, string labType)
        {
            TestContext.CurrentPage.ClickLink(link);
            CurrentPage.As<CopyLabRanges>().CopyLabRange(labType);

        }

        [StepDefinition(@"I select ""New Version"" for ""([^""]*)"" lab")]
        public void ISelect__For__Lab(string analyte)
        {
            CurrentPage.As<LabRangesPage>().AddNewVersion(analyte);
        }
        
    }
}
