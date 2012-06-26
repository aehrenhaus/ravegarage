using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class InterfaceSteps : BrowserStepsBase
	{

		[StepDefinition(@"I choose ""([^""]*)"" from ""([^""]*)""")]
		public void IChoose____From____(string text, string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromDropdown(identifer, SpecialStringHelper.Replace(text));
		}

		
		[StepDefinition(@"I pick ""([^""]*)""")]
		public void IPick____(string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromRadiobuttons(null, identifer);
		}

		[StepDefinition(@"I pick ""([^""]*)"" in ""([^""]*)""")]
		public void IPick____In____(string identifer, string areaName)
		{
			CurrentPage.ChooseFromRadiobuttons(areaName, identifer);
		}

		[StepDefinition(@"I check ""([^""]*)"" in ""([^""]*)""")]
		public void ICheck____In____(string identifer, string areaName)
		{
			CurrentPage.ChooseFromCheckboxes(areaName, identifer);
		}


		[StepDefinition(@"I check ""([^""]*)""")]
		public void ICheck____(string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(null, identifer);
		}

		[StepDefinition(@"I click button ""([^""]*)""")]
		public void IClickButton____(string textOrIdentifer)
		{
			CurrentPage = CurrentPage.ClickButton(textOrIdentifer);

		}


		/// <summary>
		/// Warning: the page object is not changed.
		/// If selecting a link causing the page changed, then use:
		///		I select "" in "" 
		///	
		/// </summary>
		/// <param name="linkText"></param>
		[StepDefinition(@"I select ""([^""]*)""")]
		public void ISelect____(string linkText)
		{
			CurrentPage = CurrentPage.ClickLink(linkText);

		}

		[StepDefinition(@"I select ""([^""]*)"" in ""([^""]*)""")]
		public void ISelect____In____(string linkText, string areaName)
		{
			CurrentPage = CurrentPage.ClickLinkInArea(linkText, areaName);
			
		}


		/// <summary>
		/// Use mapping to figure out which link to click
		/// </summary>
		/// <param name="name"></param>
		[StepDefinition(@"I navigate to ""([^""]*)""")]
		public void INavigateTo____(string identifer)
		{
			CurrentPage = CurrentPage.As<IPage>().NavigateTo(identifer);
		}

		[StepDefinition(@"I type ""([^""]*)"" in ""([^""]*)""")]
		public void IType____In____(string text, string identifer)
		{
			CurrentPage.Type(identifer, SpecialStringHelper.Replace(text));
		}

		[Then(@"I should see ""([^""]*)"" in ""([^""]*)""")]
		public void ThenIShouldSee____In____(string text, string areaName)
		{
			var cansee = CurrentPage.As<IPage>().CanSeeTextInArea(text,areaName);
			Assert.IsTrue(cansee, "Can't see {0} in {1}",text,areaName);
		}

	
	}
}
