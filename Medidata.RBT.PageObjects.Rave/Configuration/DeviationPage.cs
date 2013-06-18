﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.Configuration.Models;
using Medidata.RBT.PageObjects.Rave.TableModels;
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
            Browser.TryFindElementBy(By.XPath(".//table[@id='_ctl0_Content_" + areaIdentifier + "Grid']/.//td[contains(text(),'" + identifierToActivate + "')]/../td/a/img[contains(@src,'../../Img/i_cedit.gif')]")).Click();
            Browser.TryFindElementBy(By.XPath(".//table[@id='_ctl0_Content_" + areaIdentifier + "Grid']/.//td/input[@value='" + identifierToActivate + "']/../../td/input[contains(@id,'" + areaIdentifier + "Active')]")).EnhanceAs<Checkbox>().Check();
            Browser.TryFindElementBy(By.XPath(".//img[contains(@src,'../../Img/i_ccheck.gif')]")).Click();
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
            Browser.TryFindElementBy(By.XPath(".//table[@id='_ctl0_Content_" + areaIdentifier + "Grid']/.//td[contains(text(),'" + identifierToInactivate + "')]/../td/a/img[contains(@src,'../../Img/i_cedit.gif')]")).Click();
            Browser.TryFindElementBy(By.XPath(".//table[@id='_ctl0_Content_" + areaIdentifier + "Grid']/.//td/input[@value='" + identifierToInactivate + "']/../../td/input[contains(@id,'" + areaIdentifier + "Active')]")).EnhanceAs<Checkbox>().Uncheck();
            Browser.TryFindElementBy(By.XPath(".//img[contains(@src,'../../Img/i_ccheck.gif')]")).Click();
            return this;
        }

        /// <summary>
        /// Add Protocol Deviation Classes
        /// </summary>
        /// <param name="pdClasses">Protocol Deviation Classes to add</param>
        public void AddDeviationClasses(List<ProtocolDeviationClassModel> pdClasses)
        {
            foreach (ProtocolDeviationClassModel pdClass in pdClasses)
                AddDeviationClass(pdClass.ClassValue, pdClass.Active);
        }

        /// <summary>
        /// Add a Protocol Deviation Class
        /// </summary>
        /// <param name="classValue">Protocol Deviation Class value</param>
        /// <param name="active">Active</param>
        public void AddDeviationClass(string classValue, bool active)
        {
            Browser.TryFindElementBy(By.XPath(".//a[text()='Add Deviation Class']")).Click();
            var elClassValue = Browser.TryFindElementBy(By.XPath(".//input[contains(@id,'ClassValue')]")).EnhanceAs<Textbox>();
            elClassValue.SetText(classValue);
            var elActive = elClassValue.TryFindElementBy(By.XPath("../../td/input[contains(@id,'ClassActive')]")).EnhanceAs<Checkbox>();
            if (active)
                elActive.Check();
            else
                elActive.Uncheck();
            Browser.TryFindElementBy(By.XPath(".//img[contains(@src,'../../Img/i_ccheck.gif')]")).Click();
        }

        /// <summary>
        /// Delete the Protocol Deviation Class
        /// </summary>
        /// <param name="classValue">Protocol Deviation Class value</param>
        public void DeleteDeviationClass(string classValue)
        {
            Browser.TryFindElementBy(By.XPath(".//table[@id='_ctl0_Content_ClassGrid']/.//td[contains(text(),'" + classValue + "')]/../td/a/img[contains(@src,'../../Img/i_cedit.gif')]")).Click();
            Browser.TryFindElementByPartialID("DeleteClass").EnhanceAs<Checkbox>().Check();
            Browser.TryFindElementBy(By.XPath(".//img[contains(@src,'../../Img/i_ccheck.gif')]")).Click();
        }

        /// <summary>
        /// Add Protocol Deviation Codes
        /// </summary>
        /// <param name="pdCodes">Protocol Deviation Codes to add</param>
        public void AddDeviationCodes(List<ProtocolDeviationCodeModel> pdCodes)
        {
            foreach (ProtocolDeviationCodeModel pdCode in pdCodes)
                AddDeviationCode(pdCode.CodeValue, pdCode.Active);
        }

        /// <summary>
        /// Add a Protocol Deviation Code
        /// </summary>
        /// <param name="codeValue">Protocol Deviation Code value</param>
        /// <param name="active">Active</param>
        public void AddDeviationCode(string codeValue, bool active)
        {
            Browser.TryFindElementBy(By.XPath(".//a[text()='Add Deviation Code']")).Click();
            var elCodeValue = Browser.TryFindElementBy(By.XPath(".//input[contains(@id,'CodeValue')]")).EnhanceAs<Textbox>();
            elCodeValue.SetText(codeValue);
            var elActive = elCodeValue.TryFindElementBy(By.XPath("../../td/input[contains(@id,'CodeActive')]")).EnhanceAs<Checkbox>();
            if (active)
                elActive.Check();
            else
                elActive.Uncheck();
            Browser.TryFindElementBy(By.XPath(".//img[contains(@src,'../../Img/i_ccheck.gif')]")).Click();
        }

        /// <summary>
        /// Delete the Protocol Deviation Code
        /// </summary>
        /// <param name="codeValue">Protocol Deviation Code value</param>
        public void DeleteDeviationCode(string codeValue)
        {
            Browser.TryFindElementBy(By.XPath(".//table[@id='_ctl0_Content_CodeGrid']/.//td[contains(text(),'" + codeValue + "')]/../td/a/img[contains(@src,'../../Img/i_cedit.gif')]")).Click();
            Browser.TryFindElementByPartialID("DeleteCode").EnhanceAs<Checkbox>().Check();
            Browser.TryFindElementBy(By.XPath(".//img[contains(@src,'../../Img/i_ccheck.gif')]")).Click();
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
