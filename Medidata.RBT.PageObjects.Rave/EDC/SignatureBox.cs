using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
namespace Medidata.RBT.PageObjects.Rave
{
	public class SignatureBox : RavePageBase
	{
		public SignatureBox()
		{
			if (Context == null)
				return;
            
            //Get both user and password box at the same time.
            //If neither is found it is because something has gone wrong (TryFindElementsBy will wait until at least one is there) 
            //If 1 is found it must be the password box
            //If 2 are found they both user and password are necessary
            //We get the both at the same time so that we don't encounter the default wait every time the user box doesn't exist.
            List<IWebElement> userAndPasswordBox = Browser.TryFindElementsBy(By.XPath("*//input[contains(@id,'TwoPart') or @id='SignatureBox' or @type='password']")).ToList();

            UsernameBox = userAndPasswordBox.Count == 2 ? userAndPasswordBox.FirstOrDefault(x => x.GetAttribute("id").EndsWith("TwoPart")) : null;
            PasswordBox = userAndPasswordBox.Count == 2 ? userAndPasswordBox.FirstOrDefault(x => x.GetAttribute("id").Equals("SignatureBox")
                || x.GetAttribute("type").Equals("password")) : userAndPasswordBox[0];
            ValidateSignAndSave = Browser.TryFindElementById("ValidateSignAndSave", isWait: false);
		}

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
            return Browser.FindElementById("ESigControlTable");
		}

        public IWebElement UsernameBox { get; private set; }
        public IWebElement PasswordBox { get; private set; }
        public IWebElement ValidateSignAndSave { get; private set; }

		public void Sign(User user)
		{
            if(UsernameBox != null)
                UsernameBox.EnhanceAs<Textbox>().SetText(user.UniqueName);
            PasswordBox.EnhanceAs<Textbox>().SetText(user.Password);
            if(ValidateSignAndSave != null)
                ValidateSignAndSave.Click();
            Browser.WaitForElementToCompleteDisplayOrDisplayWithWarning(
                By.XPath("//div[@id='dialog' and (contains(@style,'display: none') or not(contains(@style,'display: block')))]"),
                By.XPath("//div[@id='dialog' and contains(@class,'oddWarning') and contains(@style,'display: block')]"));
		}

        public override string URL { get { return "NOT USED"; } }
	}
}
