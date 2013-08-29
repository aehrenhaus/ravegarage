using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Translation_Workbench
{
    public class WhereUsedPage : RavePageBase
    {
        public override IPage ClickButton(string identifier)
        {
            if (identifier == "Go Back")
            {
                IWebElement image = Browser.FindElementById("ImageButton1");
                image.Click();
                return WaitForPageLoads();
            }
            return base.ClickButton(identifier);
        }

        #region implement members for RavePageBase

        public override string URL
        {
            get { return "Modules/Translations/WhereUsed.aspx"; }
        }

        #endregion

    }
}
