using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;


namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to double data entry
    /// </summary>
	[Binding]
	public class DDESteps : BrowserStepsBase
	{
		/// <summary>
		/// Fill the form on DDE page
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I enter data in DDE")]
		public void IEnterDataInDDE(Table table)
		{
			var page = CurrentPage.As<DDEPage>();
			page.FillDataPoints(table.CreateSet<FieldModel>());
		}

		/// <summary>
		/// Open log line and fill form on DDE page
		/// </summary>
		/// <param name="line"></param>
		/// <param name="table"></param>
		[StepDefinition(@"I enter data in DDE log line (\d+)")]
		public void IEnterDataInDDELogLine____(int line, Table table)
		{
			var page = CurrentPage.As<DDEPage>();

			page.FillLoglineDataPoints(line, table);
		}

		/// <summary>
		/// Open log line and fill the form and save on DDE page.
		/// </summary>
		/// <param name="line"></param>
		/// <param name="table"></param>
		[StepDefinition(@"I enter data in DDE log line (\d+) and save")]
		public void IEnterDataInDDELogLine____AndSave(int line, Table table)
		{
			IEnterDataInDDELogLine____(line, table);
			ISaveDDE();
		}

		/// <summary>
		/// Fill form on DDE page and save
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I enter data in DDE and save")]
		public void IEnterDataInDDEAndSave(Table table)
		{
			SpecialStringHelper.ReplaceTableColumn(table, "Data");
			IEnterDataInDDE(table);
			ISaveDDE();
		}

		/// <summary>
		/// Save the form on DDE page
		/// </summary>
		[StepDefinition(@"I save the DDE page")]
		public void ISaveDDE()
		{
			CurrentPage = CurrentPage.As<DDEPage>().SaveForm();
		}
	}
}
