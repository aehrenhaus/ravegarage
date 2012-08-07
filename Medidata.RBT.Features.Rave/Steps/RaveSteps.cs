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
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using System.Collections.Specialized;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class RaveSteps : BrowserStepsBase
	{
        [StepDefinition(@"I should see the logging data for queries")]
        public void ThenIShouldSeeTheLoggingDataForQueries(Table table)
        {
            
        }



        [StepDefinition(@"I go to the log page for logger ""([^""]*)""")]
        public PageBase WhenIGoToTheLogPageForLoggerQueryNotOpeningEvent(string logger)
        {
            return new RWSLogPage(logger);
        }



	}
}
