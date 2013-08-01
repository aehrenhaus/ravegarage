using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Translation_Workbench
{
    public class WhereUsedPage : RavePageBase
    {
        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null,
                                                     string listItem = null)
        {
            if (identifier == "Go Back")
                return Browser.FindElementById("ImageButton1");

            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }

        #region implement members for RavePageBase

        public override string URL
        {
            get { return "Modules/Translations/WhereUsed.aspx"; }
        }

        #endregion

    }
}
