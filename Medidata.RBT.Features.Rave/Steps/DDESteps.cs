using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class DDESteps : BrowserStepsBase
	{
		[StepDefinition(@"I enter data in DDE")]
		public void IEnterDataInDDE(Table table)
		{
			var page = CurrentPage.As<DDEPage>();
	
			foreach (var row in table.Rows)
			{
				page.FillDataPoint(row[0], SpecialStringHelper.Replace( row[1]));
			}
		}

		[StepDefinition(@"I enter data in DDE and save")]
		public void IEnterDataInCRF(Table table)
		{
			IEnterDataInDDE(table);
			ISaveDDE();
		}

		[StepDefinition(@"I save the DDE page")]
		public void ISaveDDE()
		{
			CurrentPage = CurrentPage.As<DDEPage>().SaveForm();
		}
	}
}
