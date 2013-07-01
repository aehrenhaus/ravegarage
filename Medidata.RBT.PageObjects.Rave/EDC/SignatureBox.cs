using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
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
            List<IWebElement> userAndPasswordBox = Browser.TryFindElementsBy(By.XPath("*//input[@id = 'TwoPart' or @id='SignatureBox']")).ToList();


            UsernameBox = userAndPasswordBox.Count == 2 ? userAndPasswordBox.FirstOrDefault(x => x.GetAttribute("id") == "TwoPart") : null;
            PasswordBox = userAndPasswordBox.Count == 2 ? userAndPasswordBox.FirstOrDefault(x => x.GetAttribute("id") == "SignatureBox") : userAndPasswordBox[0];
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
            if(UsernameBox != null)
                UsernameBox.EnhanceAs<Textbox>().SetText(userName);
			PasswordBox.EnhanceAs<Textbox>().SetText(password);
			ValidateSignAndSave.Click();
		}

        public override string URL { get { return "NOT USED"; } }
       

   

	
	}
}
