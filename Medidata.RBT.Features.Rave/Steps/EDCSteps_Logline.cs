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
    /// <summary>
    /// Steps pertaining to EDC and loglines
    /// </summary>
	public partial class EDCSteps 
	{
		/// <summary>
		/// Add a new log line
		/// </summary>
		/// <FromPage>from</FromPage>
		/// <ToPage>to page</ToPage>
		[StepDefinition(@"I add a new log line")]
		public void IAddANewLogLine()
		{
			CurrentPage.As<CRFPage>().AddLogLine();
		}

        /// <summary>
        /// Open log line with the number passed in
        /// </summary>
        /// <param name="lineNum">Log line to open</param>
		[StepDefinition(@"I open log line ([^""]*)")]
		public void IOpenLogLine____(int lineNum)
		{
			CurrentPage.As<CRFPage>().OpenLogline(lineNum);
		}

        /// <summary>
        /// Open the last log line
        /// </summary>
		[StepDefinition(@"I open the last log line")]
		public void IOpenTheLastLogLine()
		{
			CurrentPage.As<CRFPage>().OpenLastLogline();
		}

        /// <summary>
        /// Open log line with the number passed in for edit
        /// </summary>
        /// <param name="lineNum">Log line to open</param>
		[StepDefinition(@"I open log line ([^""]*) for edit")]
		public void IOpenLogLine____ForEdit(int lineNum)
		{
			CurrentPage.As<CRFPage>().OpenLogline(lineNum);
		}

		#region combinations

        /// <summary>
        /// line# enter save
        /// </summary>
        /// <param name="line"></param>
        /// <param name="table"></param>
		[StepDefinition(@"I enter data in CRF on log line (\d+) and save")]
		public void IEnterDataInCRFOnLogLine____AndSave(int line, Table table)
		{
			IOpenLogLine____(line);
			IEnterDataInCRF(table);
			ISaveCRF();
		}

        /// <summary>
        /// new enter save
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"I enter data in CRF on a new log line and save")]
		public void IEnterDataInCRFOnANewLogLineAndSave(Table table)
		{
			IAddANewLogLine();
			IEnterDataInCRF(table);
			ISaveCRF();
		}

        /// <summary>
        /// last enter save
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"I enter data in CRF on the last log line and save")]
		public void IEnterDataInCRFOnTheLastLogLineAndSave(Table table)
		{
			IOpenTheLastLogLine();
			IEnterDataInCRF(table);
			ISaveCRF();

		}

        /// <summary>
        /// line# enter save open
        /// </summary>
        /// <param name="line"></param>
        /// <param name="table"></param>
		[StepDefinition(@"I enter data in CRF on log line (\d+) and save and reopen")]
		public void IEnterDataInCRFOnLogLine____AndSaveAndReopen(int line, Table table)
		{
			IEnterDataInCRFOnLogLine____AndSave(line, table);
			IOpenLogLine____(line);
		}

        /// <summary>
        /// new enter save open
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"I enter data in CRF on a new log line and save and reopen")]
		public void IEnterDataInCRFOnANewLogLineAndSaveAndReopen(Table table)
		{
			IEnterDataInCRFOnANewLogLineAndSave(table);
			IOpenTheLastLogLine();
		}

        /// <summary>
        /// last enter save open
        /// </summary>
        /// <param name="table"></param>
		[StepDefinition(@"I enter data in CRF on the last log line and save and reopen")]
		public void IEnterDataInCRFOnTheLastLogLineAndSaveAndReopen(Table table)
		{
			IEnterDataInCRFOnTheLastLogLineAndSave(table);
			IOpenTheLastLogLine();
		}
		#endregion
	}
}
