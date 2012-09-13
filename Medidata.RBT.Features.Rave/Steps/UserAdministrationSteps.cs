using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.Features.Rave
{

	[Binding]
	public class UserAdministrationSteps : BrowserStepsBase
	{
		
		[StepDefinition(@"I shoud see following controls are disabled")]
		public void IShoudSeeFollowingControlsAreDisabled(Table table)
		{
			Assert.IsTrue(CurrentPage.As<UserEditPage>().ControlsAreDisabled(table));
		}

		[StepDefinition(@"I click edit User ""([^""]*)""")]
		public void IClickEditUser____(string userName)
		{
			CurrentPage = CurrentPage.As <UserAdministrationPage>().ClickUser(userName);
		}

		[StepDefinition(@"I search User by")]
		public void ISearchUserBy(Table table)
		{
			var model = table.CreateInstance<UserAdministrationPage.SearchByModel>();

			CurrentPage.As<UserAdministrationPage>()
				.SearchUser(model);
		}
	}
}
