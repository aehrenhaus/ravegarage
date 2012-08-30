using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Common.Steps
{
	[Binding]
	public class IPageSteps : BrowserStepsBase
	{
		/// <summary>
		/// Select text from a dropdown. 
		/// </summary>
		/// <param name="text"></param>
		/// <param name="identifier"></param>
        [StepDefinition(@"I choose ""([^""]*)"" from ""([^""]*)""")]
		public void IChoose____From____(string text, string identifier)
		{
			text = SpecialStringHelper.Replace(text);
			CurrentPage = CurrentPage.ChooseFromDropdown(identifier, text);
		}

		/// <summary>
		/// Select a radio button
		/// </summary>
		/// <param name="identifier"></param>
		[StepDefinition(@"I pick ""([^""]*)""")]
		public void IPick____(string identifier)
		{
			CurrentPage = CurrentPage.ChooseFromRadiobuttons(null, identifier);
		}

		/// <summary>
		/// Select a radio button in a radio button group
		/// </summary>
		/// <param name="identifier"></param>
		/// <param name="areaName"></param>
		[StepDefinition(@"I pick ""([^""]*)"" in ""([^""]*)""")]
		public void IPick____In____(string identifier, string areaName)
		{
			CurrentPage.ChooseFromRadiobuttons(areaName, identifier);
		}

		/// <summary>
		/// I uncheck "locked" in "Study1"
		/// </summary>
		/// <param name="identifier"></param>
		/// <param name="areaName"></param>
		[StepDefinition(@"I check ""([^""]*)"" in ""([^""]*)""")]
		public void ICheck____In____(string identifier, string areaName)
		{
			CurrentPage.ChooseFromCheckboxes(identifier, true, areaName);
		}

		/// <summary>
		/// I check "locked" on "Study1" in "Studies"
		/// </summary>
		/// <param name="identifier"></param>
		/// <param name="listItem"></param>
		/// <param name="listIdentifier"></param>
		[StepDefinition(@"I check ""([^""]*)"" on ""([^""]*)"" in ""([^""]*)""")]
		public void ICheck____On___In____(string identifier, string listItem, string listIdentifier)
		{
			CurrentPage.ChooseFromCheckboxes( identifier, true, listIdentifier, listItem);
		}


		/// <summary>
		/// Check a check box
		/// </summary>
		/// <param name="identifier"></param>
		[StepDefinition(@"I check ""([^""]*)""")]
		public void ICheck____(string identifier)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(identifier,true);
		}

		/// <summary>
		/// I uncheck "locked" in "Study1"
		/// </summary>
		/// <param name="identifier"></param>
		/// <param name="areaIdentifier"></param>
		[StepDefinition(@"I uncheck ""([^""]*)"" in ""([^""]*)""")]
		public void IUncheck____In____(string identifier, string areaIdentifier)
		{
			CurrentPage.ChooseFromCheckboxes(identifier, false, areaIdentifier);
		}

		/// <summary>
		/// I uncheck "locked" on "Study1" in "Studies"
		/// </summary>
		/// <param name="identifier"></param>
		/// <param name="listItem"></param>
		/// <param name="areaIdentifier"></param>
		[StepDefinition(@"I uncheck ""([^""]*)"" on ""([^""]*)"" in ""([^""]*)""")]
		public void IUncheck____On____In____(string identifier, string listItem, string areaIdentifier)
		{
			CurrentPage.ChooseFromCheckboxes(identifier, false, areaIdentifier, listItem);
		}

		/// <summary>
		/// Uncheck a checkbox from a group
		/// </summary>
		/// <param name="identifier"></param>
		[StepDefinition(@"I uncheck ""([^""]*)""")]
		public void IUncheck____(string identifier)
		{
			CurrentPage = CurrentPage.ChooseFromCheckboxes(identifier, false);
		}

		/// <summary>
		/// Click a button
		/// </summary>
		/// <param name="textOrIdentifier"></param>
		[StepDefinition(@"I click button ""([^""]*)""")]
		public void IClickButton____(string textOrIdentifier)
		{
			CurrentPage = CurrentPage.ClickButton(textOrIdentifier);

		}


        /// <summary>
        /// Wait for x minutes
        /// </summary>
        /// <param name="minutes"></param>
        [StepDefinition(@"I wait for ([^""]*) minutes")]
        public void IWaitFor____Minutes(string minutes)
        {
            System.Threading.Thread.Sleep(60000 * int.Parse(minutes));
        }


        /// <summary>
        /// Wait for 1 minute
        /// </summary>
        [StepDefinition(@"I wait for 1 minute")]
        public void IWaitFor____Minutes()
        {
            IWaitFor____Minutes("1");
        }


		/// <summary>
		/// Click a hyperlink
		/// </summary>
		/// <param name="linkText"></param>
		[StepDefinition(@"I select link ""([^""]*)""")]
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
		[StepDefinition(@"I select link ""([^""]*)"" in ""([^""]*)""")]
		public void ISelect____In____(string linkText, string areaName)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLinkInArea(null,linkText, areaName);
			
		}

		/// <summary>
		/// Navigate to an other page.
		/// </summary>
        /// <param name="identifier"></param>
        [StepDefinition(@"I navigate to ""([^""]*)"" module")]
		[StepDefinition(@"I navigate to ""([^""]*)""")]
		public void INavigateTo____(string identifier)
		{
			CurrentPage = CurrentPage.NavigateTo(identifier);
		}

		/// <summary>
		/// Type text in a input control(textbox)
		/// </summary>
		/// <param name="text"></param>
		/// <param name="identifier"></param>
		[StepDefinition(@"I type ""([^""]*)"" in ""([^""]*)""")]
		public void IType____In____(string text, string identifier)
		{
			text = SpecialStringHelper.Replace(text);
			CurrentPage.Type(identifier, text);
		}


		/// <summary>
		/// Simulates the key stroke to the browser
		/// </summary>
		/// <param name="key"></param>
        [StepDefinition(@"I hit ""([^""]*)"" key")]
        public void IHit____Key(string key)
        {
            CurrentPage.PressKey(key);
        }
	}
}
