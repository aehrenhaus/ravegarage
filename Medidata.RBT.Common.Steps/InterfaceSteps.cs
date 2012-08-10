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
		/// <summary>
		/// Select text from a dropdown. 
		/// </summary>
		/// <param name="text"></param>
		/// <param name="identifer"></param>
        [StepDefinition(@"I choose ""([^""]*)"" from ""([^""]*)""")]
		public void IChoose____From____(string text, string identifer)
		{
			text = SpecialStringHelper.Replace(text);
			CurrentPage = CurrentPage.ChooseFromDropdown(identifer, text);
		}

		/// <summary>
		/// Select a radio button
		/// </summary>
		/// <param name="identifer"></param>
		[StepDefinition(@"I pick ""([^""]*)""")]
		public void IPick____(string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromRadiobuttons(null, identifer);
		}

		/// <summary>
		/// Select a radio button in a radio button group
		/// </summary>
		/// <param name="identifer"></param>
		/// <param name="areaName"></param>
		[StepDefinition(@"I pick ""([^""]*)"" in ""([^""]*)""")]
		public void IPick____In____(string identifer, string areaName)
		{
			CurrentPage.ChooseFromRadiobuttons(areaName, identifer);
		}

		/// <summary>
		/// Check a check box from a group
		/// </summary>
		/// <param name="identifer"></param>
		/// <param name="areaName"></param>
		[StepDefinition(@"I check ""([^""]*)"" in ""([^""]*)""")]
		public void ICheck____In____(string identifer, string areaName)
		{
			CurrentPage.ChooseFromCheckboxes(areaName, identifer, true);
		}

		/// <summary>
		/// Check a check box
		/// </summary>
		/// <param name="identifer"></param>
		[StepDefinition(@"I check ""([^""]*)""")]
		public void ICheck____(string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(null, identifer,true);
		}

		/// <summary>
		/// Uncheck a checkbox
		/// </summary>
		/// <param name="identifer"></param>
		/// <param name="areaName"></param>
		[StepDefinition(@"I uncheck ""([^""]*)"" in ""([^""]*)""")]
		public void IUncheck____In____(string identifer, string areaName)
		{
			CurrentPage.ChooseFromCheckboxes(areaName, identifer, false);
		}

		/// <summary>
		/// Uncheck a checkbox from a group
		/// </summary>
		/// <param name="identifer"></param>
		[StepDefinition(@"I uncheck ""([^""]*)""")]
		public void IUncheck____(string identifer)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(null, identifer, false);
		}

		/// <summary>
		/// Click a button
		/// </summary>
		/// <param name="textOrIdentifer"></param>
		[StepDefinition(@"I click button ""([^""]*)""")]
		public void IClickButton____(string textOrIdentifer)
		{
			CurrentPage = CurrentPage.ClickButton(textOrIdentifer);

		}

		/// <summary>
		/// Click a hyperlink
		/// </summary>
		/// <param name="linkText"></param>
		[StepDefinition(@"I select ""([^""]*)""")]
		public void ISelect____(string linkText)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText);

		}

		/// <summary>
		/// Click a hyperlink in an area
		/// </summary>
		/// <param name="linkText"></param>
		/// <param name="areaName"></param>
		[StepDefinition(@"I select ""([^""]*)"" in ""([^""]*)""")]
		public void ISelect____In____(string linkText, string areaName)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLinkInArea(null,linkText, areaName);
			
		}

		/// <summary>
		/// Navigate to an other page.
		/// </summary>
		/// <param name="name"></param>
		[StepDefinition(@"I navigate to ""([^""]*)""")]
		public void INavigateTo____(string identifer)
		{
			CurrentPage = CurrentPage.As<IPage>().NavigateTo(identifer);
		}

		/// <summary>
		/// Type text in a input control(textbox)
		/// </summary>
		/// <param name="text"></param>
		/// <param name="identifer"></param>
		[StepDefinition(@"I type ""([^""]*)"" in ""([^""]*)""")]
		public void IType____In____(string text, string identifer)
		{
			text = SpecialStringHelper.Replace(text);
			CurrentPage.Type(identifer, text);
		}

		/// <summary>
		/// Assert something (eg. text) exist in an area
		/// </summary>
		/// <param name="text"></param>
		/// <param name="areaName"></param>
		[Then(@"I should see ""([^""]*)"" in ""([^""]*)""")]
		public void IShouldSee____In____(string text, string areaName)
		{
			text = SpecialStringHelper.Replace(text);
			var cansee = CurrentPage.As<IPage>().CanSeeTextInArea(text,areaName);
			Assert.IsTrue(cansee, "Can't see {0} in {1}",text,areaName);
		}

		/// <summary>
		/// Activate something on page
		/// </summary>
		/// <param name="type"></param>
		/// <param name="identifer"></param>
		[StepDefinition(@"I activate (.+) ""([^""]*)""")]
		public void IActivate________(string type, string identifer)
		{
			CurrentPage.As<IActivatePage>().Activate(type, identifer);
		}

		/// <summary>
		/// Inactivate something on page
		/// </summary>
		/// <param name="type"></param>
		/// <param name="identifer"></param>
		[StepDefinition(@"I inactivate (.+) ""([^""]*)""")]
		public void IInactivate________(string type, string identifer)
		{
			CurrentPage.As<IActivatePage>().Inactivate(type, identifer);
		}

		/// <summary>
		/// Save something (text) from current page to a variable.
		/// This variable can be later used by using Var string replacement method
		/// </summary>
		/// <param name="identifer"></param>
		/// <param name="varName"></param>
		[StepDefinition(@"I note down ""([^""]*)"" to ""([^""]*)""")]
		public void INoteDownCrfversionTo____(string identifer, string varName)
		{
			string text = CurrentPage.GetInfomation(identifer);
			SpecialStringHelper.SetVar(varName, text);
		}

		/// <summary>
		/// Simulates the key stroke to the browser
		/// </summary>
		/// <param name="key"></param>
        [StepDefinition(@"I hit ""([^""]*)"" key")]
        public void IHit____Key(string key)
        {
            CurrentPage.As<IPage>().PressKey(key);
        }
	}
}
