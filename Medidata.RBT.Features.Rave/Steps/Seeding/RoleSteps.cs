using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class RoleSteps : BrowserStepsBase
	{


		[StepDefinition(@"Role ""([^""]*)"" has Action ""([^""]*)""")]
		public void Role____HasAction____(string roleName, string actionNames)
		{

		}

	}
}
