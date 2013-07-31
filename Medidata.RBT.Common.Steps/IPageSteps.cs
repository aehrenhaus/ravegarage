﻿using TechTalk.SpecFlow;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.Common.Steps
{
    /// <summary>
    /// Steps pertaining to all pages
    /// </summary>
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
        /// Unused step
        /// </summary>
        /// <param name="objectType"></param>
        /// <param name="text"></param>
        /// <param name="identifier"></param>
		[StepDefinition(@"I choose ([^""]*) ""([^""]*)"" from ""([^""]*)""")]
		public void IChoose________From____(string objectType, string text, string identifier)
		{
			text = SpecialStringHelper.Replace(text);
			CurrentPage = CurrentPage.ChooseFromDropdown(identifier, text, objectType);
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
		/// Click a button
		/// </summary>
		/// <param name="textOrIdentifier"></param>
		[StepDefinition(@"I click button ""([^""]*)""")]
		public void IClickButton____(string textOrIdentifier)
		{
			CurrentPage = CurrentPage.ClickButton(textOrIdentifier);

		}

		/// <summary>
		/// Click a hyperlink
		/// </summary>
		[StepDefinition(@"I select link ""([^""]*)""")]
		public void ISelect____(string linkText)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText);
		}

        /// <summary>
        /// Click a partial hyperlink
        /// </summary>
        [StepDefinition(@"I select link\(partial\) ""([^""]*)""")]
		public void ISelectLinkPartial____(string linkText)
        {
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText,null,null,true);
        }

		/// <summary>
		/// I select link "Mediflex" in "Header"
		/// </summary>
		[StepDefinition(@"I select link ""([^""]*)"" in ""([^""]*)""")]
		public void ISelectLink____In____(string linkText, string areaName)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText, null, areaName);

		}

        /// <summary>
        /// Unused step
        /// </summary>
        /// <param name="objectType"></param>
        /// <param name="linkText"></param>
		[StepDefinition(@"I select (.+) link ""([^""]*)""")]
		public void ISelect____Type____Link____(string objectType, string linkText)
		{
			if (objectType != null && objectType.StartsWith(@"""") && objectType.EndsWith(@""""))
			{
				objectType = objectType.Substring(1, objectType.Length - 2);
			}

			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText, objectType);
		}

		/// <summary>
		/// I select link(partial) "Mediflex" in "Header"
		/// </summary>
		[StepDefinition(@"I select link\(partial\) ""([^""]*)"" in ""([^""]*)""")]
		public void ISelectLink____PartialIn____(string linkText, string areaName)
		{
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText, null, areaName, true);
		}

		/// <summary>
		/// I select "Study" link "Mediflex" in "Header"
		/// </summary>
		[StepDefinition(@"I select (.*) link ""([^""]*)"" in ""([^""]*)""")]
		public void ISelect____Type____Link____In____(string objectType, string linkText, string areaName)
		{
			if (objectType != null && objectType.StartsWith(@"""") && objectType.EndsWith(@""""))
			{
				objectType = objectType.Substring(1, objectType.Length - 2);
			}
			linkText = SpecialStringHelper.Replace(linkText);
			CurrentPage = CurrentPage.ClickLink(linkText, objectType, areaName);
		}

		/// <summary>
		/// Navigate to another page.
		/// 
		/// Unlike "I select link", the intention of this step is to allow direct navigation to a portion of Rave.
        /// For example, if you were to have:
        /// And I select link "Configuration"
        /// And I select link "Other Settings"
        /// And I select link "Deviations"
        /// 
        /// You can instead have:
        /// And I navigate to "Deviations"
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
