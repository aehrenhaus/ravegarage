using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;

using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class RaveSteps : BrowserStepsBase
	{
        [StepDefinition(@"I should see the logging data for queries")]
        public void IShouldSeeTheLoggingDataForQueries(Table table)
        {
            
        }

        [StepDefinition(@"I go to the log page for logger ""([^""]*)""")]
        public PageBase IGoToTheLogPageForLoggerQueryNotOpeningEvent(string logger)
        {
            return new RWSLogPage(logger);
        }

        /// <summary>
        /// Step definition to check if a the text stored in the scenario text contains the listed symbols. Fails if it does.
        /// </summary>
        /// <param name="table">The list of characters to look for</param>
        /// <returns></returns>
        [StepDefinition(@"the text should not contain ""<Symbol>""")]
        public void TheTextShouldNotContainSymbol(Table table)
        {
            Assert.IsFalse(String.IsNullOrEmpty(TestContext.ScenarioText));

            if (CreateSymbolsTable(table).Any(s => TestContext.ScenarioText.Contains(s)))
                Assert.Fail();
        }

        /// <summary>
        /// Step definition to check if a the text stored in the scenario text contains all the listed symbols. Succeeds if it does.
        /// </summary>
        /// <param name="table">The list of characters to look for</param>
        /// <returns></returns>
        [StepDefinition(@"the text should contain ""<Symbol>""")]
        public void TheTextShouldContainSymbol(Table table)
        {
            Assert.IsFalse(String.IsNullOrEmpty(TestContext.ScenarioText));

            if (CreateSymbolsTable(table).Any(s => !TestContext.ScenarioText.Contains(s)))
                Assert.Fail();
        }

        /// <summary>
        /// Create the symbols table using the passed in table from the feature file
        /// </summary>
        /// <param name="table">Table from the feature file</param>
        /// <returns>All the strings in the symbol table</returns>
        private List<String> CreateSymbolsTable(Table table)
        {
            List<String> symbols = new List<string>();

            foreach (TableRow tableRow in table.Rows)
            {
                string value = tableRow["Symbol"];
                symbols.Add(value);
            }

            return symbols;
        }
	}
}
