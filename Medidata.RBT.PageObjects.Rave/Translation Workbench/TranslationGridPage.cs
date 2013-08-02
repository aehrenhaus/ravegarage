using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Translation_Workbench
{
    public class TranslationGridPage : RavePageBase, IEnterValues, IVerifyObjectExistence
    {
        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "SearchButtonImage")
                return Browser.FindElementById("_ctl0_Content_TranslationGridForm_Search");

            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }

        public IPage SelectTheFirstOfUsesLink()
        {
            var element = GetTheFirstOfUsesLink();
            element.Click();
            return WaitForPageLoads();
        }

        #region implement members for RavePageBase

        public override string URL
        {
            get { return "Modules/Translations/TranslationGrid.aspx"; }
        }

        #endregion

        #region implement members for IEnterValues

        public void EnterIntoTextbox(string identifier, string valueToEnter)
        {
            if (identifier == "Search")
            {
                var textbox = Browser.FindElementById("_ctl0_Content_TranslationGridForm_StrFilter").EnhanceAs<Textbox>();
                if (textbox == null) throw new Exception("Textbox not found");
                textbox.Clear();
                textbox.SendKeys(valueToEnter);
            }
        }

        #endregion

        #region implement members for IVerifyObjectExistence

        public bool VerifyObjectExistence(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null, bool shouldExist = true)
        {
            return String.IsNullOrEmpty(identifier) ? VerifyObjectExistenceByType(type) : VerifyObjectExistenceByIdentifier(identifier);
        }

        public bool VerifyObjectExistence(string areaIdentifier, string type, List<string> identifiers, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null, bool shouldExist = true)
        {
            throw new NotImplementedException();
        }

        #endregion

        #region Helpers

        private IWebElement GetTheFirstOfUsesLink()
        {
            List<IWebElement> rows = Browser.FindElementById("_ctl0_Content_TranslationGridForm_Results").EnhanceAs<HtmlTable>().Rows().ToList();
            IWebElement row = rows[1];
            IWebElement element = row.TryFindElementByPartialID("WhereUsedDiv");
            return element;
        }

        private bool VerifyObjectExistenceByType(string type)
        {
            if (type == "table")
            {
                var element = GetTheFirstOfUsesLink();
                return element != null;
            }
            return false;
        }

        private bool VerifyObjectExistenceByIdentifier(string identifier)
        {
            if (identifier == "Generating results...")
                return Browser.FindElementById("_ctl0_Content_TranslationGridForm_GeneratingResults").GetCssValue("display") == "block";

            if (identifier == "SearchButtonImage")
                return Browser.FindElementById("_ctl0_Content_TranslationGridForm_Search").GetCssValue("display") == "inline";

            return false;
        }

        #endregion

    }
}