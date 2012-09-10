using System;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Common.Steps
{
    [Binding]
    public class IActivateSteps : BrowserStepsBase
    {
		/// <summary>
		/// Inactivate something on page
		/// </summary>
		/// <param name="type"></param>
		/// <param name="identifier"></param>
		[StepDefinition(@"I inactivate (.+) ""([^""]*)""")]
		public void IInactivate________(string type, string identifier)
		{
			CurrentPage.As<IActivatePage>().Inactivate(type, identifier);
		}


		/// <summary>
		/// Activate something on page
		/// </summary>
		/// <param name="type"></param>
		/// <param name="identifier"></param>
		[StepDefinition(@"I activate (.+) ""([^""]*)""")]
		public void IActivate________(string type, string identifier)
		{
			CurrentPage.As<IActivatePage>().Activate(type, identifier);
		}

	}
}
