using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
namespace Medidata.RBT.PageObjects.Rave
{
	public class PasswordPage : RavePageBase
	{
        [FindsBy(How = How.Id, Using = "_ctl0_Content_NewPasswordBox")]
        public IWebElement NewPasswordBox;

        [FindsBy(How = How.Id, Using = "_ctl0_Content_ConfirmPasswordBox")]
        public IWebElement ConfirmPasswordBox;

        public PasswordPage()
		{
			PageFactory.InitElements(Browser, this);
		}

        public override IPage ClickButton(string buttonID)
        {
            base.ClickButton(buttonID);
            if (buttonID == "_ctl0_Content_SavePasswordButton")
            {
                TestContext.CurrentPage = new PasswordChangedPage();
                return TestContext.CurrentPage;
            }
            return this;
        }

        public override string URL{ get { return "Password.aspx"; }}
	}
}
