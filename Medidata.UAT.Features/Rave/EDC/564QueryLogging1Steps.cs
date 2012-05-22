using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using System.Diagnostics;
using Medidata.UAT.Features;
using Medidata.UAT.WebDrivers.Rave;
using Medidata.UAT.WebDrivers;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Remote;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.UAT.Features.Rave;

namespace Medidata.UAT.StepDefinitions.Rave
{
	[Binding]
	public class Rave564QueryLogging1Steps : FeatureStepsUsingBrowser
	{

		[When(@"I enter search text")]
		public void IEnterSearchText()
		{
			CurrentPage.As<HomePage>().EnterSearch("this is a demo");
		}

		[When(@"I click search")]
		public void IClickSearch()
		{
			CurrentPage.As<HomePage>().ClickSearch();
		}

		[Then(@"I sould see result")]
		public void IShouldSeeResult()
		{
			Assert.IsTrue( CurrentPage.As<HomePage>().CanSeeResult("some thing"),"Can't see result");
		}
		
	}

}
