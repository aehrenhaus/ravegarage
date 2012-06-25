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
		public void IChoose____From____(string text, string dropdownName)
		{
			CurrentPage = CurrentPage.ChooseFromDropdown(dropdownName, SpecialStringHelper.Replace(text));
		}

		
		[StepDefinition(@"I pick ""([^""]*)""")]
		public void IPick____(string name)
		{
			CurrentPage = CurrentPage.ChooseFromRadiobuttons(null, name);
		}

		[StepDefinition(@"I pick ""([^""]*)"" in ""([^""]*)""")]
		public void IPick____In____(string name, string areaName)
		{
			CurrentPage = CurrentPage.ChooseFromRadiobuttons(areaName, name);
		}

		[StepDefinition(@"I check ""([^""]*)"" in ""([^""]*)""")]
		public void ICheck____In____(string names, string areaName)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(areaName, names.Split(','));
		}


		[StepDefinition(@"I check ""([^""]*)""")]
		public void ICheck____(string names)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(null, names.Split(','));
		}

		[StepDefinition(@"I click button ""([^""]*)""")]
		public void IClickButton____(string textOrName)
		{
			CurrentPage = CurrentPage.ClickButton(textOrName);

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
		public void INavigateTo____(string name)
		{
			CurrentPage = CurrentPage.As<IPage>().NavigateTo(name);
		}

		[StepDefinition(@"I type ""([^""]*)"" in ""([^""]*)""")]
		public void IType____In____(string text, string textboxName)
		{
			CurrentPage.Type(textboxName, SpecialStringHelper.Replace( text));
		}

		[Then(@"I should see ""([^""]*)"" in ""([^""]*)""")]
		public void ThenIShouldSee____In____(string text, string areaName)
		{
			var cansee = CurrentPage.As<IPage>().CanSeeTextInArea(text,areaName);
			Assert.IsTrue(cansee, "Can't see {0} in {1}",text,areaName);
		}

	
	}
}
