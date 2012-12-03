using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class SignatureBox : RavePageBase
	{
		public SignatureBox()
		{
            UsernameBox = Browser.TryFindElementById("TwoPart");
            PasswordBox = Browser.TryFindElementById("SignatureBox");
            ValidateSignAndSave = Browser.TryFindElementById("ValidateSignAndSave");

		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
            return Browser.FindElementById("ESigControlTable");
		}

        public IWebElement UsernameBox { get; private set; }
        public IWebElement PasswordBox { get; private set; }
        public IWebElement ValidateSignAndSave { get; private set; }

		public void Sign(string userName, string password)
		{
            try
            {
                UsernameBox.EnhanceAs<Textbox>().SetText(userName);
            }
            catch
            {
            }
			PasswordBox.EnhanceAs<Textbox>().SetText(password);
			ValidateSignAndSave.Click();
		}

        public override string URL { get { return "NOT USED"; } }
       

   

	
	}
}
