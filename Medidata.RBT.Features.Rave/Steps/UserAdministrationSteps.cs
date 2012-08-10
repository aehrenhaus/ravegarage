using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using System.Collections.Specialized;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Features.Rave
{

	[Binding]
	public class UserAdministrationSteps : BrowserStepsBase
	{
		
		[StepDefinition(@"I shoud see following controls are disabled")]
		public void IShoudSeeFollowingControlsAreDisabled(Table table)
		{
			Assert.IsTrue(CurrentPage.As<ICanVerify>().ControlsAreDisabled(table));
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
