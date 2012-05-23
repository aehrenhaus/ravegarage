using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.UAT.Features;
using TechTalk.SpecFlow;
using Medidata.UAT.WebDrivers;
using Medidata.UAT.WebDrivers.Rave;

namespace Medidata.UAT.Features.Rave
{
	[Binding]
	public class CommonEDCSteps : FeatureStepsUsingBrowser
	{
		/// <summary>
		/// Verify in database only
		/// Will not modify from db or UI
		/// </summary>
		/// <param name="table"></param>
		[Given(@"Rave has user-study-site assignments from the table below:")]
		public void GivenRaveHasUser_Study_SiteAssignmentsFromTheTableBelow(Table table)
		{
	
		}

		/// <summary>
		/// Verify in database only
		/// Will not modify from db or UI
		/// </summary>
		[Given(@"Role ""(.*)"" has ""(.*)"" Action")]
		public void GivenRole____Has____Action(string roleName,string actionNames)
		{
	
		}

		/// <summary>
		/// Verify in database only
		/// Will not modify from db or UI
		/// </summary>
		[Given(@"Study  ""(.*)"" has Draft ""(.*)""")]
		public void GivenStudy____HasDraft____(string studyName, string draftName)
		{
			
		}


		[Given(@"CRF ""(.*)"" is pushed in Site ""(.*)""")]
		public void GivenCRF____IsPushedInSite____(string crfName,string siteName)
		{
			
		}

		/// <summary>
		/// Will use Subject Name field . 
		/// If  the field is not present, then subjectName is not used
		/// </summary>
		/// <param name="subjectName"></param>
		[Given(@"I create a Subject ""(.*)""")]
		public void GivenICreateASubject____(string subjectName)
		{
			
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="folderName"></param>
		[Given(@"I select Folder ""(.*)""")]
		public void GivenISelectFolder____(string folderName)
		{
			
		}


		[Given(@"I select Form ""(.*)""")]
		public void GivenISelectForm____(string formName)
		{
	
		}


		[Given(@"I fill current Form with")]
		public void GivenIFillCurrentFormWith(Table table)
		{
		
		}



		[Given(@"I take screenshot (.*)")]
		public void GivenITakeScreenshot____(string screenshotName)
		{
			
		}


		[Given(@"I verify Field ""(.*)"" displays Query and requires response")]
		public void GivenIVerifyField____DisplaysQueryAndRequiresResponse(string fieldNames)
		{

		}

		[Given(@"I answer the Query on Field ""(.*)"" with ""(.*)""")]
		public void GivenIAnswerTheQueryOnField____With____(string fieldName, string answer)
		{

		}

		[Given(@"I save current Form")]
		public void GivenISaveCurrentForm()
		{
			;
		}

		[Given(@"I close the Query on Field ""(.*)""")]
		public void GivenICloseTheQueryOnField____(string fieldNames)
		{
	
		}

		[Given(@"I verify Field ""(.*)"" has NO Query")]
		public void GivenIVerifyField____HasNOQuery(string fieldNames)
		{
	
		}


		[When(@"I select Form ""(.*)"" in Folder ""(.*)""")]
		public void WhenISelectForm____InFolder____(string fieldName,string folderName)
		{
			
		}

		[When(@"I run SQL Script ""(.*)"" I shoud see result")]
		public void WhenIRunSQLScript____IShoudSeeResult(string scriptName, Table table)
		{
		
		}

		[When(@"I add a new log line")]
		public void WhenIAddANewLogLine()
		{
	
		}
	}
}
