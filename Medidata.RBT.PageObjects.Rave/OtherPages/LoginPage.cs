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

		public HomePage Login(string userName, string password)
		{
			UsernameBox.EnhanceAs<Textbox>().SetText(userName);
			PasswordBox.EnhanceAs<Textbox>().SetText(password);
			LoginButton.Click();

			return new HomePage();
		}

        public override string URL{ get { return "login.aspx"; }}
       

   

	
	}
}
