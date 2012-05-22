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
using Medidata.UAT.Features.Rave.DataModels;

namespace Medidata.UAT.StepDefinitions.Rave
{
	[Binding]
	public class Rave564QueryLogging1Steps : FeatureStepsUsingBrowser
	{


		[When(@"bla")]
		public void fasfswefewsfe()
		{
			
		}
		[When(@"bla2")]
		public void fasfswefewsfe1()
		{

		}

		[When(@"user ""User""  has study ""Study"" and role ""Role"" and site ""Site"" has Site Number in database ""<EDC>"", from the table below")]
		public void WhenUserUsersHasStudyStudyAndRoleRoleAndSiteSiteHasSiteNumberInDatabaseEDCFromTheTableBelow(Table table)
		{
			//ISet<UserStudySiteRole> assignments = table.CreateSet<UserStudySiteRole>();

			//foreach (var assign in assignments)
			//{

			//}

			foreach (var row in table.Rows)
			{
				string str = row["User"];
			}
		}

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
