using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Objects.Integration.Helpers;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Integration.Steps
{
    [Binding]
    public class RoleSteps
    {
        [Given(@"the Role with Name ""(.*)"" exists in the Rave database")]
        public void GivenARoleWithName____Exists(string name)
        {
            RoleHelper.AddRoleToDB(name, true);
        }
    }
}
