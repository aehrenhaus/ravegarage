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
        [StepDefinition(@"I login to Rave with user ""([^""]*)"" and password ""([^""]*)""")]
		public void ILoginToRaveWithUsername____AndPassword____(string username, string password)
		{
			LoginPage page = new LoginPage();
			page.NavigateToSelf();
            CurrentPage = page.Login(username, password);
			
		}

		/// <summary>
		/// 
		/// </summary>
        [StepDefinition(@"I am logged in to Rave with default account")]
		[StepDefinition(@"I login to Rave with default account")]
        public void ILoginToRaveWithDefaultAccount()
        {
            ILoginToRaveWithUsername____AndPassword____(RaveConfiguration.Default.DefaultUser,
                                            RaveConfiguration.Default.DefaultUserPassword);
        }


		/// <summary>
		/// Login to rave with the username and password in configuration
		/// </summary>
		/// <param name="userName">Feature name of the user</param>
        [StepDefinition(@"I login to Rave with user ""([^""]*)""")]
		public void ILoginToRaveWithUser____(string userName)
		{
            if (userName.Equals("defuser"))
            {
                ILoginToRaveWithDefaultAccount();
            }
            else
            {
                User user = TestContext.GetExistingFeatureObjectOrMakeNew(userName, () => new User(userName));
                LoginPage.LoginToHomePageIfNotAlready(user.UniqueName, user.Password);
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
