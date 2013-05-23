using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.Configuration.Models;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class DeviationPage : ConfigurationBasePage, IActivatePage
    {
        #region IPage
        /// <summary>
        /// See IPage interface
        /// </summary>
        public override string URL
        {
            get { return "Modules/Configuration/Deviations.aspx"; }
        }

        #endregion


        #region Public Methods
        /// <summary>
        /// Verifies something exist.
        /// </summary>
        /// <param name="areaIdentifier">The area identifier.</param>
        /// <param name="identifier">The identifier.</param>
        /// <returns></returns>
        public bool VerifySomethingExist(string areaIdentifier, string identifier)
        {
            HtmlTable parentArea = SelectDeviationTable(areaIdentifier);
            if (parentArea != null)
            {
                return parentArea.Rows()[0].Text.Contains(" " + identifier + " ");
            }
			return false;
		}

        /// <summary>
        /// Verifies the row checked.
        /// </summary>
        /// <param name="columnIdentifier">The column identifier.</param>
        /// <param name="rowIdentifier">The row identifier.</param>
        /// <param name="areaIdentifier">The area identifier.</param>
        /// <returns></returns>
        public bool VerifyRowChecked(string columnIdentifier, string rowIdentifier, string areaIdentifier)
        {
            HtmlTable parentArea = SelectDeviationTable(areaIdentifier);
            if (parentArea != null)
            {
                foreach (var row in parentArea.Rows().Skip(1))
                {
                    Textbox txt = row.Textboxes().FirstOrDefault();
                    if (txt != null && txt.Value.Equals(rowIdentifier, StringComparison.CurrentCultureIgnoreCase))
                    {
                        return GetCheckBox(row, areaIdentifier + "Active").Checked;
                    }
                }
            }
            return false;
        }


        /// <summary>
        /// Rows the selected for edit.
        /// </summary>
        /// <param name="rowIdentifier">The row identifier.</param>
        /// <param name="areaIdentifier">The area identifier.</param>
        public void RowSelectedForEdit(string rowIdentifier, string areaIdentifier)
        {
            HtmlTable parentArea = SelectDeviationTable(areaIdentifier);
            if (parentArea != null)
            {
                var matchTable = new Table(areaIdentifier + " Value");
                matchTable.AddRow(rowIdentifier);
                var row = GetMatchingRow(parentArea, matchTable);
                if (row != null)
                {
                    IWebElement updateButton = row.TryFindElementByXPath(".//img[contains(@src, 'i_cedit.gif')]");
                    updateButton.Click();
                }
            }
        }

        /// <summary>
        /// Activates the specified type.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <param name="identifierToActivate">The identifier to activate.</param>
        /// <returns></returns>
        public IPage Activate(string type, string identifierToActivate) 
        {
            string areaIdentifier = type == "deviation code" ? "Code" : "Class";
            var row = GetRow(identifierToActivate, areaIdentifier, false);
            IWebElement updateButton = row.TryFindElementByXPath(".//img[contains(@src, 'i_cedit.gif')]");
            updateButton.Click();
            row = GetRow(identifierToActivate, areaIdentifier, true);
            GetCheckBox(row, areaIdentifier + "Active").Check();

            updateButton = row.TryFindElementByXPath(".//img[contains(@src, 'i_ccheck.gif')]");
            updateButton.Click();
            return this;
        }

        /// <summary>
        /// Inactivates the specified type.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <param name="identifierToInactivate">The identifier to inactivate.</param>
        /// <returns></returns>
        public IPage Inactivate(string type, string identifierToInactivate)
        {
            string areaIdentifier = type == "deviation code" ? "Code" : "Class";
            var row = GetRow(identifierToInactivate, areaIdentifier, false);
            IWebElement updateButton = row.TryFindElementByXPath(".//img[contains(@src, 'i_cedit.gif')]");
            updateButton.Click();
            row = GetRow(identifierToInactivate, areaIdentifier, true);
            GetCheckBox(row, areaIdentifier + "Active").Uncheck();

            updateButton = row.TryFindElementByXPath(".//img[contains(@src, 'i_ccheck.gif')]");
            updateButton.Click();
            return this;
        }
        #endregion

        #region Private Methods


        private HtmlTable SelectDeviationTable(string areaIdentifier)
        {
            HtmlTable parentArea = null;
            if (String.Compare(areaIdentifier, "Class", StringComparison.CurrentCultureIgnoreCase) == 0)
            {
                parentArea = Browser.TryFindElementById("_ctl0_Content_ClassGrid").EnhanceAs<HtmlTable>();
            }
            else if (String.Compare(areaIdentifier, "Code", StringComparison.CurrentCultureIgnoreCase) == 0)
            {
                parentArea = Browser.TryFindElementById("_ctl0_Content_CodeGrid").EnhanceAs<HtmlTable>();
            }
            return parentArea;
        }

        private IWebElement GetRow(string identifierToInactivate, string areaIdentifier, bool editMode)
        {
            IWebElement row = null;
            HtmlTable parentArea = SelectDeviationTable(areaIdentifier);
            if (parentArea != null)
            {
                if (!editMode)
                {
                    var matchTable = new Table(areaIdentifier + " Value");
                    matchTable.AddRow(identifierToInactivate);
                    row = GetMatchingRow(parentArea, matchTable);
                }
                else
                {
                    row = parentArea.Rows().Skip(1).FirstOrDefault(rw => rw.FindElementsByPartialId(areaIdentifier + "Value") != null);
                }

            }

            return row;
        }

        private IWebElement GetMatchingRow(HtmlTable parentArea, Table tableToMatch)
        {
            return parentArea.FindMatchRows(tableToMatch).FirstOrDefault();
        }

        private Checkbox GetCheckBox(IWebElement row, string Id)
        {
            return row.TryFindElementByPartialID(Id).EnhanceAs<Checkbox>();
        }

        #endregion
    }
}
