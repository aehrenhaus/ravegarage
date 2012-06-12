using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class MiscSteps:BrowserStepsBase
	{

		[StepDefinition(@"I take a screenshot")]
		public void ITakeScreenshot()
		{
			TestContext.TrySaveScreenShot();
		}

	}
}
