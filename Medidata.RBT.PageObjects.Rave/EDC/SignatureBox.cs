using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class SignatureBox : RavePageBase
	{
		public SignatureBox()
		{
			PageFactory.InitElements(Browser, this);
		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
            return Browser.FindElementById("ESigControlTable");
		}

		[FindsBy(How = How.Id, Using = "TwoPart")]
		public IWebElement UsernameBox;

		[FindsBy(How = How.Id, Using = "SignatureBox")]
		public IWebElement PasswordBox;


		[FindsBy(How = How.Id, Using = "ValidateSignAndSave")]
        public IWebElement ValidateSignAndSave;

		public void Sign(string userName, string password)
		{
			UsernameBox.EnhanceAs<Textbox>().SetText(userName);
			PasswordBox.EnhanceAs<Textbox>().SetText(password);
			ValidateSignAndSave.Click();
		}

        public override string URL { get { return "NOT USED"; } }
       

   

	
	}
}
