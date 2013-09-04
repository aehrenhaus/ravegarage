using System;
using TechTalk.SpecFlow;
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
        [StepDefinition(@"I select image ""(.*)""")]
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
        /// Click a hyperlink when the linkname itself contains double quotes
        /// </summary>
        /// <param name="linkText"></param>
        [StepDefinition(@"I select link containing quotes ""(.*?)""")]
        public void WhenISelectLinkContainingDoubleQuotes____(string linkText)
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

        /// <summary>
        /// Simulates the browser back button
        /// </summary>
        [StepDefinition(@"I go back to the previous page via the browser back button")]
        public void GivenIGoBackToThePreviousPageViaTheBrowserBackButton()
        {
            // Using version 2.33.0.0 of Selenium on .NET 4.0
            // There are a number of issues with Selenium and Back Navigation
            // However with future releases; hopefully this is resolved and scenarios using GoBack can be enabled 
            // https://code.google.com/p/selenium/issues/detail?id=3611
            // https://code.google.com/p/selenium/issues/detail?id=2181
            // http://stackoverflow.com/questions/17958595/selenium-using-the-old-page-after-browser-back-button-action-and-not-showing-alt?noredirect=1#comment26296287_17958595
            Browser.Navigate().Back();
            /*
            Browser.ExecuteScript("history.go(-1);", new Object[0]);
            Browser.ExecuteScript("javascript: setTimeout(\"history.go(-1)\", 2000)");
            */
        }
	}
}
