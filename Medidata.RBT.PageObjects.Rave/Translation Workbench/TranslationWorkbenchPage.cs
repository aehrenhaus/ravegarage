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
        public override IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
            Dropdown dropdown = null;
            if (identifier == "Source locale") dropdown = Browser.DropdownById("_OriginalLocale");
            if (identifier == "Target locale") dropdown = Browser.DropdownById("_TargetLocale");

            if (dropdown != null)
            {
                dropdown.SelectByText(text);
                return this;  
            }
            return base.ChooseFromDropdown(identifier, text, objectType, areaIdentifier);
        }

        public override IPage ChooseFromRadiobuttons(string areaIdentifier, string identifier)
        {
            RadioButton radioButton = null;
            if (identifier == "Standard") radioButton = Browser.RadioButton("_StringCategory_0");
            if (identifier == "User/Global") radioButton = Browser.RadioButton("_StringCategory_1");
            if (identifier == "User/Clinical") radioButton = Browser.RadioButton("_StringCategory_2");

            if (radioButton != null)
            {
                radioButton.Set();
                return this;
            }
            return base.ChooseFromRadiobuttons(areaIdentifier, identifier);
        }

        #region implement members for RavePageBase

        public override string URL
        {
            get { return "Modules/Translations/TranslationWorkbench.aspx"; }
        }

        #endregion

    }
}
