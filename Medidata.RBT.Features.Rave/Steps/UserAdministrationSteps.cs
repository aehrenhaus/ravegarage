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
	}
}
