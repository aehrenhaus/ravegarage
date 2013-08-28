using System;
using Medidata.RBT.ConfigurationHandlers;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps pertaining to User Administration
    /// </summary>
	[Binding]
	public class UserAdministrationSteps : BrowserStepsBase
	{
		/// <summary>
		/// Check that controls for a user in user administation are disabled
		/// </summary>
		/// <param name="table">The controls to check</param>
		[StepDefinition(@"I shoud see following controls are disabled")]
		public void IShoudSeeFollowingControlsAreDisabled(Table table)
		{
			Assert.IsTrue(CurrentPage.As<UserEditPage>().ControlsAreDisabled(table));
		}

        /// <summary>
        /// Click edit for a certain user
        /// </summary>
        /// <param name="userName">User to edit</param>
		[StepDefinition(@"I click edit User ""([^""]*)""")]
		public void IClickEditUser____(string userName)
		{
			CurrentPage = CurrentPage.As <UserAdministrationPage>().ClickUser(userName);
		}

        /// <summary>
        /// Search for a user in user administation with certain parameters
        /// </summary>
        /// <param name="table">Parameters to search for the user by</param>
		[StepDefinition(@"I search User by")]
		public void ISearchUserBy(Table table)
		{
			var model = table.CreateInstance<UserAdministrationPage.SearchByModel>();

			CurrentPage.As<UserAdministrationPage>()
				.SearchUser(model);
		}

        /// <summary>
        /// Search for a user in user administation with seeded context
        /// </summary>
        /// <param name="table">Parameters to search for the user by</param>
        [StepDefinition(@"I search User by seeded login")]
        public void ISearchUserBySeededLogin(Table table)
        {
            var model = table.CreateInstance<UserAdministrationPage.SearchByModel>();

            if (model.Login != null)
            {
                User u = SeedingContext.GetExistingFeatureObjectOrMakeNew(model.Login, () => new User(model.Login));
                model.Login = u.UniqueName;
            }

            CurrentPage.As<UserAdministrationPage>()
                .SearchUser(model);
        }

        /// <summary>
        /// Upload the user file back that was downloaded with user loader
        /// </summary>
        [StepDefinition(@"I upload the User file that I last downloaded")]
        public void WhenIUploadTheUserFileThatILastDownloaded()
        {
            string filename=WebTestContext.LastDownloadedFile.FullName;
            WebTestContext.Browser.FindElementById("_ctl0_Content_FileUpload").SendKeys(filename);
            CurrentPage.ClickButton("Upload");
            WaitForUploadToComplete();
        }

        /// <summary>
        /// Wait for the userfile to finish uploading
        /// </summary>
        private void WaitForUploadToComplete()
        {
            int waitTime = RBTConfiguration.Default.UploadTimeout;
            var ele = Browser.TryFindElementBy(b =>
            {
                IWebElement currentStatus = Browser.FindElementByXPath("//span[@id = 'CurrentStatus']");
                if (currentStatus.Text.Contains("Upload successful") || currentStatus.Text.Contains("Transaction rolled back."))
                    return currentStatus;
                else
                    return null;
            }
                , true, waitTime);

            if (ele == null)
                throw new Exception(
                "Did not complete in time(" + waitTime + "s)");
        }
	}
}
