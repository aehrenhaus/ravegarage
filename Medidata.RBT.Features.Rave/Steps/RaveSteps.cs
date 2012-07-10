using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class RaveSteps : BrowserStepsBase
	{
        [StepDefinition(@"I should see the logging data for queries")]
        public void ThenIShouldSeeTheLoggingDataForQueries(Table table)
        {
            
        }

		[StepDefinition(@"I navigate to ""([^""]*)"" page with parameters")]
		public void INavigateTo____PageWithParameters(string pageName, Table table)
		{
			//TODO:Set parameters from table
			PageBase page = RavePageObjectFactory.GetPage(pageName.Replace(" ", "") + "Page") as PageBase;
			foreach (var row in table.Rows)
			{
				page.Parameters[row["Name"]]=row["Value"];
			}
			CurrentPage = page.NavigateToSelf();
		}

		[StepDefinition(@"I navigate to ""([^""]*)"" page")]
		public void INavigateTo____Page(string pageName)
		{
		
			CurrentPage = RavePageObjectFactory.GetPage(pageName.Replace(" ", "") + "Page").NavigateToSelf();
		}

        [StepDefinition(@"I go to the log page for logger ""([^""]*)""")]
        public PageBase WhenIGoToTheLogPageForLoggerQueryNotOpeningEvent(string logger)
        {
            return new RWSLogPage(logger);
        }
	}
}
