using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class InterfaceSteps : BrowserStepsBase
	{

		[StepDefinition(@"I choose ""([^""]*)"" from ""([^""]*)""")]
		public void IChoose____From____(string text, string dropdownName)
		{
			CurrentPage.Choose(dropdownName, text);
		}

		[StepDefinition(@"I click ""([^""]*)""")]
		public void IClick____(string buttonName)
		{
			CurrentPage.Click(buttonName);

		}

		/// <summary>
		/// Use mapping to figure out which link to click
		/// </summary>
		/// <param name="name"></param>
		[StepDefinition(@"I navigate to ""([^""]*)""")]
		public void INavigateTo____(string name)
		{
			CurrentPage = CurrentPage.As<INavigationPage>().NavigateTo(name);
		}

		[StepDefinition(@"I type ""([^""]*)"" in ""([^""]*)""")]
		public void IType____In____(string text, string textboxName)
		{
			CurrentPage.Type(textboxName, text);
		}
	
	}
}
