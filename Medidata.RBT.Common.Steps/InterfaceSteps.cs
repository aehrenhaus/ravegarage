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
			text = SpecialStringHelper.Replace(text);
			CurrentPage = CurrentPage.ChooseFromDropdown(identifer, text);
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
			CurrentPage.ChooseFromCheckboxes(areaName, identifer, true);
		}


		[StepDefinition(@"I check ""([^""]*)""")]
		public void ICheck____(string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(null, identifer,true);
		}

		[StepDefinition(@"I uncheck ""([^""]*)"" in ""([^""]*)""")]
		public void IUncheck____In____(string identifer, string areaName)
		{
			CurrentPage.ChooseFromCheckboxes(areaName, identifer, false);
		}


		[StepDefinition(@"I uncheck ""([^""]*)""")]
		public void IUncheck____(string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(null, identifer, false);
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
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText);

		}

		[StepDefinition(@"I select ""([^""]*)"" in ""([^""]*)""")]
		public void ISelect____In____(string linkText, string areaName)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLinkInArea(null,linkText, areaName);
			
		}

		[StepDefinition(@"I select ([^""]*) ""([^""]*)"" in ""([^""]*)""")]
		public void ISelect________In____(string type, string linkText, string areaName)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLinkInArea(type, linkText, areaName);

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
			text = SpecialStringHelper.Replace(text);
			CurrentPage.Type(identifer, text);
		}

		[Then(@"I should see ""([^""]*)"" in ""([^""]*)""")]
		public void ThenIShouldSee____In____(string text, string areaName)
		{
			text = SpecialStringHelper.Replace(text);
			var cansee = CurrentPage.As<IPage>().CanSeeTextInArea(text,areaName);
			Assert.IsTrue(cansee, "Can't see {0} in {1}",text,areaName);
		}

		[StepDefinition(@"I activate (.+) ""([^""]*)""")]
		public void IActivate________(string type, string identifer)
		{
			CurrentPage.As<IActivatePage>().Activate(type, identifer);
		}

		[StepDefinition(@"I inactivate (.+) ""([^""]*)""")]
		public void IInactivate________(string type, string identifer)
		{
			CurrentPage.As<IActivatePage>().Inactivate(type, identifer);
		}

		[StepDefinition(@"I note down ""([^""]*)"" to ""([^""]*)""")]
		public void INoteDownCrfversionTo____(string identifer, string varName)
		{
			string text = CurrentPage.GetText(identifer);
			SpecialStringHelper.SetVar(varName, text);
		}
	}
}
