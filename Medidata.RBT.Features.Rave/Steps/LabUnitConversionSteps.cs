using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public partial class LabUnitConversionSteps : BrowserStepsBase
	{
        [When(@"I add new unit conversion data")]
        public void WhenIAddNewUnitConversionData(Table table)
        {
            SpecialStringHelper.ReplaceTableColumn(table, "Data");
        }

	}
}
