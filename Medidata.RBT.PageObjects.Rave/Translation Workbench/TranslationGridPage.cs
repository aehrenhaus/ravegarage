using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Translation_Workbench
{
    public class TranslationGridPage : RavePageBase, IEnterValues
    {
        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null,
                                             string listItem = null)
        {
            if (identifier == "SearchButtonImage")
                return Browser.FindElementById("_ctl0_Content_TranslationGridForm_Search");

            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }

        public IPage SelectTheFirstOfUsesLink()
        {
            List<IWebElement> rows = Browser.FindElementById("_ctl0_Content_TranslationGridForm_Results").EnhanceAs<HtmlTable>().Rows().ToList();
            IWebElement row = rows[1];
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
                if (textbox == null) throw new Exception("Textbox not found");
                textbox.Clear();
                textbox.SendKeys(valueToEnter);
            }
        }

        #endregion
    }
}
