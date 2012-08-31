using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;


namespace Medidata.RBT.Features.Rave
{
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
		/// <param name="user"></param>
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
