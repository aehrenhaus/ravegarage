using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;


namespace Medidata.RBT.Features.Rave
{
    /// <summary>
    /// Steps to login to Rave
    /// </summary>
	[Binding]
	public class LoginSteps : BrowserStepsBase
	{
		/// <summary>
		/// Login to rave with given usernamem and password
		/// </summary>
		/// <param name="username"></param>
		/// <param name="password"></param>
        [StepDefinition(@"I am logged in to Rave with username ""([^""]*)"" and password ""([^""]*)""")]
		public void ILoginToRaveWithUsername____AndPassword____(string username, string password)
		{
			LoginPage page = new LoginPage();
			page.NavigateToSelf();
            CurrentPage = page.Login(username, password);
			
		}

		/// <summary>
		/// Login to rave with the username and password in configuration
		/// </summary>
		/// <param name="userName">Feature name of the user</param>
        [StepDefinition(@"I log in to Rave with user ""([^""]*)""")]
        [StepDefinition(@"I login to Rave with user ""([^""]*)""")]
		public void ILoginToRaveWithUser(string userName)
		{
            string password = RaveConfiguration.Default.DefaultUserPassword;
            if (userName.Equals("defuser"))
            {
                LoginPage page = new LoginPage();
                page.NavigateToSelf();
                CurrentPage = page.Login(userName, password);
            }
            else
            {
                User user = TestContext.GetExistingFeatureObjectOrMakeNew(userName, () => new User(userName, true));

                LoginPage page = new LoginPage();
                page.NavigateToSelf();
                CurrentPage = page.Login(user.UniqueName, password);
            }
		}

		/// <summary>
		/// Click logout on Rave
		/// </summary>
        [StepDefinition(@"I log out of Rave")]
        public void ILogOutOfRave()
        {
            CurrentPage.ClickLink("Logout");
        }
	}
}
