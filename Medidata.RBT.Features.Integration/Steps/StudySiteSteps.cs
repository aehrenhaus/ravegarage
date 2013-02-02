using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Objects.Integration.Helpers;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class StudySiteSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Given(@"the StudySite with ExternalId ""(.*)"" exists in the Rave database")]
        public void TheStudySiteWithID____ExistsInTheRaveDatabase(int externalId)
        {
            StudySiteHelper.CreateRaveStudySite(externalId);
        }
    }
}
