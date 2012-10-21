using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class LoginPage : RavePageBase
	{
		public LoginPage()
		{
			PageFactory.InitElements(Browser, this);
		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			return Browser.FindElementById("_ctl0_Content_chkReqResponse");
		}

		[FindsBy(How = How.Id, Using = "UserLoginBox")]
		public IWebElement UsernameBox;

		[FindsBy(How = How.Id, Using = "UserPasswordBox")]
		public IWebElement PasswordBox;

		[FindsBy(How = How.Id, Using = "LoginButton")]
		IWebElement LoginButton;

        /// <summary>
        /// Login the default user from any page.
        /// </summary>
        public static void LoginToHomePageIfNotAlready(string userName = null, string password = null)
        {
            //user default if not assigned
            userName = userName ?? RaveConfiguration.Default.DefaultUser;
            password = password ?? RaveConfiguration.Default.DefaultUserPassword;

            //if not the user
            if ( TestContext.CurrentUser != userName)
            {
                var loginPage = new LoginPage();
                loginPage.NavigateToSelf();
                var homePage = loginPage.Login(userName, password);
                TestContext.CurrentPage = homePage;
            }

            if(!(TestContext.CurrentPage is HomePage))
            {
                TestContext.CurrentPage = new HomePage().NavigateToSelf();
            }

        }

        /// <summary>
        /// Login using the provided username and password
        /// </summary>
        /// <param name="userName">The username to login with</param>
        /// <param name="password">The username to password with</param>
        /// <returns>The home page after logging in</returns>
		public HomePage Login(string userName, string password)
		{
			UsernameBox.EnhanceAs<Textbox>().SetText(userName);
			PasswordBox.EnhanceAs<Textbox>().SetText(password);
			LoginButton.Click();

            TestContext.CurrentUser = userName;
            TestContext.CurrentPage = new HomePage();
            return (HomePage)TestContext.CurrentPage;
		}

        public override IPage ClickLink(string linkText)
        {
            base.ClickLink(linkText);
            if (linkText == "Activate New Account")
            {
                TestContext.CurrentPage = new ActivatePage();
                return TestContext.CurrentPage;
            }
            return this;
        }

        public override string URL{ get { return "login.aspx"; }}
	}
}
