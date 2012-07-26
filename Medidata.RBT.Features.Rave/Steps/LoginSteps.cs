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

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public class LoginSteps : BrowserStepsBase
	{
        [StepDefinition(@"I am logged in to Rave with username ""([^""]*)"" and password ""([^""]*)""")]
		public void ILoginToRaveWithUsername____AndPassword____(string username, string password)
		{
			LoginPage page = new LoginPage();
			page.NavigateToSelf();
            CurrentPage = page.Login(username, password);
			
		}

        [StepDefinition(@"I login to Rave with user ""([^""]*)""")]
		public void ILoginToRaveWithUser(string user)
		{
			string username,password =null;
			username = RaveConfiguration.Default.DefaultUser;
			password = RaveConfiguration.Default.DefaultUserPassword;

			LoginPage page = new LoginPage();
			page.NavigateToSelf();
			CurrentPage = page.Login(username, password);
		}

        [StepDefinition(@"I log out of Rave")]
        public void ILogOutOfRave()
        {
            CurrentPage.SelectLink("Logout");
        }
	}
}
