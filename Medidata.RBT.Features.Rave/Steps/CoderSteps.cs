using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using System.Collections.Generic;
using Medidata.RBT.Utilities;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Linq;
using System.Text.RegularExpressions;
using Medidata.RBT.PageObjects.Rave.EDC.Models;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to mimicing the functionality of coder
    /// </summary>
	[Binding]
	public class CoderSteps : BrowserStepsBase
	{
        /// <summary>
        /// This step mimicks coder coding a data point.
        /// It does this by setting the datapoint to no longer require coding and changing the uncoded field value 
        /// to a new value we are calling the coded value.
        /// 
        /// This will not show on the page automatically, 
        /// since we are not triggering the datapoint save and datapage save.
        /// However, if you navigate away and back to the page it will show up.
        /// 
        /// It is IMPORTANT that the uncoded data is never used in the same study and field in another place.
        /// These 3 variables make a fake primary key, since we have control over the uncoded data it should never be the same in two places
        /// </summary>
        /// <param name="table"></param>
        [StepDefinition(@"I code data points")]
        public void ThenICodeDataPoint(Table table)
        {
            List<CodeDataPointModel> dataPointModels = table.CreateSet<CodeDataPointModel>().ToList();
            foreach (CodeDataPointModel dpm in dataPointModels)
            {
                Project proj = SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(dpm.Project, () => { throw new Exception("Project is not seeded"); });
                CodingDictionary codingDictionary = SeedingContext.GetExistingFeatureObjectOrMakeNew<CodingDictionary>(dpm.CodingDictionary, ()
                    => new CodingDictionary(dpm.CodingDictionary, dpm.CodingDictionaryVersion));
                User currentUser = SeedingContext.GetExistingFeatureObjectOrMakeNew<User>(dpm.CurrentUser, () => { throw new Exception("User is not seeded"); });

                DataPoint dp = new DataPoint(proj.UniqueName, SpecialStringHelper.Replace(dpm.Subject), dpm.Field, dpm.UncodedData, "eng");
                dp.CodeDataPoint(dpm.CodedData, codingDictionary.DictionaryVersion, currentUser.UserID, currentUser.UniqueName);
            }

            this.Browser.Navigate().Refresh();
        }
	}
}
