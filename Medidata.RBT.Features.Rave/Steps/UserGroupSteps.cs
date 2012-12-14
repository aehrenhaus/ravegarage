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
    /// <summary>
    /// Stepts pertaining to user groups
    /// </summary>
    [Binding]
    public partial class UserGroupSteps : BrowserStepsBase
    {
        /// <summary>
        /// XML config file is uploaded for seeding purposes.
        /// </summary>
        /// <param name="configName">The name of user group configuration to be loaded (seeded)</param>
        [StepDefinition(@"xml User Group Configuration ""([^""]*)"" is uploaded")]
        public void XmlDraft____IsUploaded(string configName)
        {
            TestContext.GetExistingFeatureObjectOrMakeNew<UserGroupConfiguration>(configName, () => new UserGroupConfiguration(configName));
        }
    }
}
