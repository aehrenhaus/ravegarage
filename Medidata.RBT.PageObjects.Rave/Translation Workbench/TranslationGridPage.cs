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
        public override IPage ClickButton(string identifier)
        {
            if (identifier == "SearchButtonImage")
            {
                IWebElement image = Browser.FindElementById("_ctl0_Content_TranslationGridForm_Search");
                image.Click();
                return WaitForPageLoads();
            }
            return base.ClickButton(identifier);
        }

        /// <summary>
        /// Method to click the uses link in a given row
        /// </summary>
        /// <param name="position">The row</param>
        /// <returns>The page that is navigated to as a result of clicking the uses link</returns>
        public IPage SelectTheUsesLinkInRow(int position)
        {
            List<IWebElement> rows = Browser.FindElementById("_ctl0_Content_TranslationGridForm_Results").EnhanceAs<HtmlTable>().Rows().ToList();
            IWebElement row = rows[position];
            IWebElement element = row.TryFindElementByPartialID("WhereUsedDiv");
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
                if (textbox == null) throw new NoSuchElementException("Textbox not found");
                textbox.Clear();
                textbox.SendKeys(valueToEnter);
            }
        }

        #endregion

        #region implement members for IVerifyObjectExistence

        public bool VerifyObjectExistence(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null, bool shouldExist = true)
        {
            switch (identifier)
            {
                case "Generating results...":
                    return Browser.FindElementById("_ctl0_Content_TranslationGridForm_GeneratingResults").GetCssValue("display") == "block";
                case "SearchButtonImage":
                    return Browser.FindElementById("_ctl0_Content_TranslationGridForm_Search").GetCssValue("display") == "inline";
            }

            return false;
        }

        public bool VerifyObjectExistence(string areaIdentifier, string type, List<string> identifiers, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null, bool shouldExist = true)
        {
            return identifiers.All(identifier => VerifyObjectExistence(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold));
        }

        #endregion

    }
}