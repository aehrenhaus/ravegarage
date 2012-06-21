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
	public partial class EDCSteps : BrowserStepsBase
	{
		[StepDefinition(@"I select Study ""([^""]*)"" and Site ""([^""]*)""")]
		public void ISelectStudy____AndSite____(string studyName, string siteName)
		{
			CurrentPage = CurrentPage.As<HomePage>()
				.SelectStudy(studyName)
				.SelectSite(siteName);
		}

		/// <summary>
		/// subjectName accepts replacements
		/// </summary>
		[StepDefinition(@"I select a Subject ""([^""]*)""")]
		public void ISelectASubject____(string subjectName)
		{
			CurrentPage = CurrentPage.As<HomePage>().SelectSubject(SpecialStringHelper.Replace(subjectName));
		}

		/// <summary>
		/// value column accepts replacements
		/// </summary>
		/// <param name="table"></param>
		[StepDefinition(@"I create a Subject")]
		public void ICreateASubject____(Table table)
		{
			SpecialStringHelper.ReplaceTableColumn(table, "Value");
			CurrentPage = CurrentPage.As<HomePage>().CreateSubject(table);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="folderName"></param>
		[StepDefinition(@"I select Folder ""([^""]*)""")]
		public void ISelectFolder____(string folderName)
		{
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectFolder(folderName);

		}

		[StepDefinition(@"I select Form ""([^""]*)""")]
		public void ISelectForm____(string formName)
		{
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectForm(formName);
		}


		[StepDefinition(@"I enter data in CRF")]
		public void IEnterDataInCRF(Table table)
		{
			CRFPage page = CurrentPage.As<CRFPage>();
			page.ClickModify();
			foreach (var row in table.Rows)
			{
				page.FillDataPoint(row[0], row[1]);
			}
		}

		[StepDefinition(@"I enter data in CRF and save")]
		public void IEnterDataInCRFAndSave(Table table)
		{
			IEnterDataInCRF(table);
			ISaveCRF();
		}



		[StepDefinition(@"I select Form ""([^""]*)"" in Folder ""([^""]*)""")]
		public void ISelectForm____InFolder____(string formName, string folderName)
		{
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectFolder(folderName);
			CurrentPage = CurrentPage.As<BaseEDCTreePage>().SelectForm(formName);
		}


		//[StepDefinition(@"I save the ""[^""]*"" page")]
		[StepDefinition(@"I save the CRF page")]
		public void ISaveCRF()
		{
			CurrentPage = CurrentPage.As<CRFPage>().SaveForm();
		}

		[StepDefinition(@"I cancel the ""[^""]*"" page")]
		[StepDefinition(@"I cancel the CRF page")]
		public void ICancelCRF()
		{
			CurrentPage = CurrentPage.As<CRFPage>().CancelForm();
		}
		

		[StepDefinition(@"I am on CRF page ""([^""]*)"" in Folder ""([^""]*)"" in Subject ""([^""]*)"" in Site ""([^""]*)"" in Study ""([^""]*)""")]
		public void IAmOnCRFPage____InFolder___InSubject____InSite____InStudy____(string formName, string folderName, string subjectName, string siteName, string studyName)
		{
			CurrentPage = CurrentPage.As<HomePage>()
				.SelectStudy(studyName)
				.SelectSite(siteName)
				.SelectSubject(subjectName)
				.SelectFolder(folderName)
				.SelectForm(formName);
		}

	}
}
