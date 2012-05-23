using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.UAT.Features;
using TechTalk.SpecFlow;
using Medidata.UAT.WebDrivers;
using Medidata.UAT.WebDrivers.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.UAT.Features.Rave
{
	[Binding]
	public class CommonEDCSteps : FeatureStepsUsingBrowser
	{
		#region Given


		[Given(@"Rave has user-study-site assignments from the table below:")]
		public void RaveHasUser_Study_SiteAssignmentsFromTheTableBelow(Table table)
		{
	
		}

		[Given(@"Role ""([^""]*)"" has ""([^""]*)"" Action")]
		public void Role____Has____Action(string roleName,string actionNames)
		{
	
		}

		[Given(@"Study  ""([^""]*)"" has Draft ""([^""]*)""")]
		public void Study____HasDraft____(string studyName, string draftName)
		{
			
		}

		[Given(@"CRF ""([^""]*)"" is pushed in Site ""([^""]*)""")]
		public void CRF____IsPushedInSite____(string crfName,string siteName)
		{
			
		}

		#endregion

		#region When Then


		[When(@"I login to Rave with username ""([^""]*)"" and password ""([^""]*)""")]
		[Then(@"I login to Rave with username ""([^""]*)"" and password ""([^""]*)""")]
		public void ILoginToRaveWithUsername____AndPassword____(string username,string passowrd)
		{
			LoginPage page = LoginPage.New();
			CurrentPage = page.Login(username, passowrd);
		}

		[When(@"I create a Subject ""([^""]*)""")]
		[Then(@"I create a Subject ""([^""]*)""")]
		public void ICreateASubject____(string subjectName)
		{
			var url = new Uri(Browser.Url);
			Assert.AreEqual(url.ToString(), UATConfiguration.Default.RaveURL + "HomePage");

		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="folderName"></param>
		[When(@"I select Folder ""([^""]*)""")]
		[Then(@"I select Folder ""([^""]*)""")]
		public void ISelectFolder____(string folderName)
		{
			
		}


		[When(@"I select Form ""([^""]*)""")]
		[Then(@"I select Form ""([^""]*)""")]
		public void ISelectForm____(string formName)
		{
	
		}


		[When(@"I fill current Form with")]
		public void IFillCurrentFormWith(Table table)
		{
		
		}


		[When(@"I take screenshot ([^""]*)")]
		[When(@"I take screenshot ([^""]*)")]
		public void ITakeScreenshot____(string screenshotName)
		{
			
		}


		[When(@"I verify Field ""([^""]*)"" displays Query and requires response")]
		public void IVerifyField____DisplaysQueryAndRequiresResponse(string fieldNames)
		{

		}

		[When(@"I answer the Query on Field ""([^""]*)"" with ""([^""]*)""")]
		public void IAnswerTheQueryOnField____With____(string fieldName, string answer)
		{

		}

		[When(@"I answer the Query on Field ""([^""]*)""")]
		public void IAnswerTheQueryOn____(string filedNames)
		{

		}

		[When(@"I save current Form")]
		public void ISaveCurrentForm()
		{
			;
		}

		[When(@"I close the Query on Field ""([^""]*)""")]
		public void ICloseTheQueryOnField____(string fieldNames)
		{
	
		}

		[When(@"I verify Field ""([^""]*)"" has NO Query")]
		public void IVerifyField____HasNOQuery(string fieldNames)
		{
	
		}


		[When(@"I select Form ""([^""]*)"" in Folder ""([^""]*)""")]
		public void ISelectForm____InFolder____(string fieldName,string folderName)
		{
			
		}

		[When(@"I run SQL Script ""([^""]*)"" I shoud see result")]
		public void IRunSQLScript____IShoudSeeResult(string scriptName, Table table)
		{
		
		}


		[When(@"I run SQL Script ""([^""]*)"" I shoud NOT see result")]
		public void IRunSQLScript____IShoudNOTSeeResult(string scriptName, Table table)
		{
	
		}

		[When(@"I add a new log line")]
		public void IAddANewLogLine()
		{

		}


		[When(@"I open log line ([^""]*)")]
		public void IOpenLogLine2(int lineNum)
		{
			
		}

		[When(@"I modify current form with")]
		public void IModifyCurrentFormWith(Table table)
		{

		}



		#endregion

	}
}
