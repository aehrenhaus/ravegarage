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
			CurrentPage = CurrentPage.Choose(dropdownName, SpecialStringHelper.Replace(text));
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
	
	}
}
