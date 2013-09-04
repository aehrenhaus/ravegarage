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
            switch (identifier)
            {
                case "Source locale":
                    dropdown = Browser.DropdownById("_OriginalLocale");
                    break;
                case "Target locale":
                    dropdown = Browser.DropdownById("_TargetLocale");
                    break;
            }

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
            switch (identifier)
            {
                case "Standard":
                    radioButton = Browser.RadioButton("_StringCategory_0");
                    break;
                case "User/Global":
                    radioButton = Browser.RadioButton("_StringCategory_1");
                    break;
                case "User/Clinical":
                    radioButton = Browser.RadioButton("_StringCategory_2");
                    break;
            }

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
