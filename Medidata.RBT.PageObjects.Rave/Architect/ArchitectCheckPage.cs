using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ArchitectCheckPage : ArchitectBasePage
    {
        /// <summary>
        /// Method to verify tab name for Edit Check
        /// </summary>
        /// <param name="editCheckName"></param>
        public void VerifyTabName(string editCheckName)
        {
            IWebElement eTab = this.Browser.TryFindElementByXPath(string.Format("//a[@title='{0}']", editCheckName));
            bool isCorrect;
            if (eTab != null)
                isCorrect = true;
            else
                isCorrect = false;
            Assert.IsTrue(isCorrect, String.Format("Tab name is correct: {0}", editCheckName));
        }

        public override string URL
        {
            get
            {
                return "Modules/Architect/Check.aspx";
            }
        }

        /// <summary>
        /// Verifies the deviation.
        /// </summary>
        /// <param name="columnIdentifier">The column identifier.</param>
        /// <param name="rowIdentifier">The row identifier.</param>
        /// <param name="exists">if set to <c>true</c> [exists].</param>
        /// <returns></returns>
        public bool VerifyDeviation(string columnIdentifier, string rowIdentifier, bool exists)
        {
            bool isExists = true;
            var dropdown = Browser.TryFindElementByPartialID("ActionTypeDDL").EnhanceAs<Dropdown>();
            dropdown.SelectByText("Add Deviation");

            string areaIdentifier =
                String.Compare(columnIdentifier, "class", StringComparison.CurrentCultureIgnoreCase) == 0
                    ? "DropDownTwo"
                    : "DropDownOne";

            dropdown = Browser.TryFindElementByPartialID(areaIdentifier).EnhanceAs<Dropdown>();

            if (exists)
            {
                isExists = dropdown.VerifyByText(rowIdentifier) == true;
            }
            else
            {
                isExists = dropdown.VerifyByText(rowIdentifier) == false;
            }

            return isExists;
        }
    }
}
