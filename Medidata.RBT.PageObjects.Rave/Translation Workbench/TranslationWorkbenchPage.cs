using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Translation_Workbench
{
    public class TranslationWorkbenchPage : RavePageBase
    {
        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null,
                                                     string listItem = null)
        {
            if (identifier == "Source locale")
                return Browser.DropdownById("_OriginalLocale");

            if (identifier == "Target locale")
                return Browser.DropdownById("_TargetLocale");

            if (identifier == "Standard")
                return Browser.RadioButton("_StringCategory_0");

            if (identifier == "User/Global")
                return Browser.RadioButton("_StringCategory_1");

            if (identifier == "User/Clinical")
                return Browser.RadioButton("_StringCategory_2");

            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }

        #region implement members for RavePageBase

        public override string URL
        {
            get { return "Modules/Translations/TranslationWorkbench.aspx"; }
        }

        #endregion

    }
}
