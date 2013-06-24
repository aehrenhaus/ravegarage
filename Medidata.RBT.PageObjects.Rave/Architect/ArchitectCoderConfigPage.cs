using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Support.UI;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ArchitectCoderConfigPage : ArchitectBasePage, IVerifyObjectExistence, IVerifyRowsExist
    {
        public override string URL
        {
            get
            {
                return "Modules/Architect/CoderConfigPage.aspx";
            }
        }

        /// <summary>
        /// This method should be used to enter the coder configuration data such as coding level, priority
        /// and locale. Note this method will select the values not save them.
        /// </summary>
        /// <param name="coderConf"></param>
        public void FillCoderConfigurationData(ArchitectCoderConfigurationModel coderConf)
        {
            IWebElement controlTd = FindControlTdFromAreaIdentifier(coderConf.ConfigurationName);
            //Check to ensure that Td corresponding to coder control has at least one child before we attempt to enter data
            if (controlTd != null && controlTd.Children().Count() > 0)
            {
                IWebElement controlElem = controlTd.Children()[0];
                if (coderConf.ControlType.Equals("dropdown", StringComparison.InvariantCultureIgnoreCase))
                    controlElem.EnhanceAs<Dropdown>().SelectByText(coderConf.Data);
                else if (coderConf.ControlType.Equals("textbox", StringComparison.InvariantCultureIgnoreCase))
                    controlElem.EnhanceAs<Textbox>().SetText(coderConf.Data);
            }
            
        }

        /// <summary>
        /// Method to allow fill the coder workflow variable settings using the workflow model
        /// Name, value based model will let set the workflow variable to true or false
        /// </summary>
        /// <param name="coderWorkflowVariable"></param>
        public void SetCoderWorkflowVariable(CoderWorkflowVariableModel coderWorkflowVariable)
        {
            //Based on workflow variable name choose the appropriate row to be edited
            EditCoderConfTableRow(coderWorkflowVariable.Name, GetTableIdFromTableName("Workflow Variables"));

            IWebElement valueElem = Browser.TryFindElementByPartialID("_ValueDDL");
            valueElem.EnhanceAs<Dropdown>().SelectByText(coderWorkflowVariable.Value);

            IWebElement checkButton = Browser.TryFindElementByXPath(".//img[contains(@src, 'i_ccheck.gif')]");
            checkButton.Click();
        }

        /// <summary>
        /// Method to add Supplemental or Component terms for coder
        /// </summary>
        /// <param name="termName">Variable to information whether the term to be added is Supplemental or Component</param>
        /// <param name="coderTerm">Name and Component Name based model to allow selecting Supplemental/Component model</param>
        public void AddCoderTerm(string termName, CoderTermModel coderTerm)
        {
            if (termName.Equals("Supplemental", StringComparison.InvariantCultureIgnoreCase))
                AddSupplementalCoderTerm(coderTerm);
            else if (termName.Equals("Component", StringComparison.InvariantCultureIgnoreCase))
                AddComponentCoderTerm(coderTerm);
            else
                throw new InvalidOperationException(string.Format("No coder term named {0} exist", termName)); //If not Supplemental or Component model throw exception
        }


        /// <summary>
        /// Delete the Supplemental or Component term in coder configuration
        /// </summary>
        /// <param name="termName">Either Supplemental or Component</param>
        /// <param name="coderTerm">Name and Component Name passed as CoderTermModel</param>
        public void DeleteCoderTerm(string termName, CoderTermModel coderTerm)
        {
            Table dt = new Table("Name");
            dt.AddRow(coderTerm.Name);

            termName = termName + " Terms";
            string tableId = GetTableIdFromTableName(termName);

            EditCoderConfTableRow(coderTerm.Name, tableId);

            HtmlTable table = Browser.TryFindElementById(tableId).EnhanceAs<HtmlTable>();
            IWebElement workflowTr = table.FindMatchRows(dt).FirstOrDefault();
            //select the delete checkbox for table row where specified coder term exist followed by
            //clicking the update button
            workflowTr.TryFindElementByPartialID("_DeleteDictionaryCB").EnhanceAs<Checkbox>().Check();
            IWebElement updateButton = workflowTr.TryFindElementByXPath(".//img[contains(@src, 'i_ccheck.gif')]");
            updateButton.Click();
        }

        #region private helper methods

        /// <summary>
        /// Helper method to click edit button for coder workflow variable, supplemental term or 
        /// component term table based on the configuratin name and table id
        /// </summary>
        /// <param name="confName">Name of the coder supplemental,workflow or component term to be edited</param>
        /// <param name="tableId">id of the table where the row containing coder conf term exist</param>
        private void EditCoderConfTableRow(string confName, string tableId)
        {
            Table dt = new Table("Name");
            dt.AddRow(confName);

            HtmlTable table = Browser.TryFindElementById(tableId).EnhanceAs<HtmlTable>();
            IWebElement workflowTr = table.FindMatchRows(dt).FirstOrDefault();

            IWebElement editButton = workflowTr.TryFindElementByXPath(".//img[contains(@src, 'i_cedit.gif')]");
            editButton.Click();

            //wait for check image to make sure page has loaded
            Browser.TryFindElementByXPath(".//img[contains(@src, 'i_ccheck.gif')]", true, 10);
        }

        /// <summary>
        /// Helper method to allow adding coder supplemental term
        /// </summary>
        /// <param name="coderTerm"></param>
        private void AddSupplementalCoderTerm(CoderTermModel coderTerm)
        {
            this.ChooseFromDropdown("_ctl0_Content_m_CoderFieldConfig_FieldNameForSuppDDL", coderTerm.Name);  
            this.ClickButton("_ctl0_Content_m_CoderFieldConfig_BtnAddSupplemental");
        }

        /// <summary>
        /// Helper method to allow adding coder component term
        /// </summary>
        /// <param name="coderTerm"></param>
        private void AddComponentCoderTerm(CoderTermModel coderTerm)
        {
            this.ChooseFromDropdown("_ctl0_Content_m_CoderFieldConfig_FieldNameForCompDDL", coderTerm.Name);
            this.ChooseFromDropdown("_ctl0_Content_m_CoderFieldConfig_ComponentDDL", coderTerm.ComponentName);
            this.ClickButton("_ctl0_Content_m_CoderFieldConfig_BtnAddComponent");
        }

        /// <summary>
        /// Helper method to get the table id for workflow variable, Supplemental or Component table based on table name
        /// </summary>
        /// <param name="tableName"></param>
        /// <returns></returns>
        private string GetTableIdFromTableName(string tableName)
        {
            string tableId = "";

            if (tableName.Equals("Workflow Variables", StringComparison.InvariantCultureIgnoreCase))
            {
                tableId = "_ctl0_Content_m_CoderFieldConfig_VariableGrid";
            }
            else if (tableName.Equals("Supplemental Terms", StringComparison.InvariantCultureIgnoreCase))
            {
                tableId = "_ctl0_Content_m_CoderFieldConfig_SupplementalGrid";
            }
            else if (tableName.Equals("Component Terms", StringComparison.InvariantCultureIgnoreCase))
            {
                tableId = "_ctl0_Content_m_CoderFieldConfig_ComponentGrid";
            }
            else
                throw new NotImplementedException(string.Format("No implementation found for the specified table {0}", tableName));

            return tableId;
        }

        /// <summary>
        /// Helper method to find the coder configuration control td id based on the coder configuration name
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <returns></returns>
        private IWebElement FindControlTdFromAreaIdentifier(string areaIdentifier)
        {
            IWebElement elem = Browser.TryFindElementByXPath(string.Format(".//td/span[text()='{0}']", areaIdentifier)).Parent(); //find td corresponding the coder config name
            int controlPosition = elem.Parent().Children().IndexOf(elem) + 1; //find the position of the control td
            int controlTrPosition = elem.Parent().Parent().Children().IndexOf(elem.Parent()) + 2; //find the position of the control tr

            //find the td corresponding to the same position as the configuration name but in the second tr
            IWebElement controlTd = elem.TryFindElementByXPath(string.Format("../../tr[position()={0}]/td[position()={1}]", controlTrPosition, controlPosition));

            return controlTd;
        }

        /// <summary>
        /// Helper method to support the generic VerifySomethingExist to add support for verifying the text exist
        /// This method support coder configuration control text verification and can verify dropdown and texbox controls
        /// selected text verification
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <param name="identifier"></param>
        /// <returns></returns>
        private bool VerifyTextExist(string areaIdentifier, string identifier)
        {
            IWebElement controlTdElem = FindControlTdFromAreaIdentifier(areaIdentifier);

            if (controlTdElem != null && controlTdElem.Children().Count() > 0)
            {
                IWebElement controlElem = controlTdElem.Children()[0];
                bool textExists = false;

                if (controlElem.TagName.Equals("select", StringComparison.InvariantCultureIgnoreCase))
                {
                    //create instance of SelementElement from IWebElement with tagname 'select' to be able to
                    //verify the text of the selected option
                    SelectElement selectElem = new SelectElement(controlElem);
                    textExists = selectElem.SelectedOption.Text.Equals(identifier, StringComparison.InvariantCultureIgnoreCase);
                }
                else if (controlElem.TagName.Equals("input", StringComparison.InvariantCultureIgnoreCase))
                {
                    textExists = controlElem.GetAttribute("value").Equals(identifier, StringComparison.InvariantCultureIgnoreCase);
                }

                return textExists;
            }

            throw new NotImplementedException(
                string.Format("Verify text exist does not have implementation for area identifier {0} and identifier {1}", areaIdentifier, identifier));
        }
        #endregion

        #region IVerifySomethingExist
        /// <summary>
        /// Implementation of the IVerifySomethingExist interface for ArchitectCoderConfigPage
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <param name="type"></param>
        /// <param name="identifier"></param>
        /// <param name="exactMatch"></param>
        /// <returns></returns>
        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            string identifier,
            bool exactMatch = true,
            int? amountOfTimes = null,
            BaseEnhancedPDF pdf = null,
            bool? bold = null,
            bool shouldExist = true)
        {
            if (areaIdentifier.Equals("Coding Level", StringComparison.InvariantCultureIgnoreCase))
                return VerifyCodingLevelExists(identifier);
            else if (areaIdentifier.Equals("Priority", StringComparison.InvariantCultureIgnoreCase))
                return VerifyPriority(identifier);
            //Support for verifying existing text, for verifying anything else the if else statement should be extended
            else if (type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
                return VerifyTextExist(areaIdentifier, identifier);
            else
            {
                //if specified type does not exist then throw not implemented exception
                throw new NotImplementedException(string.Format("No implementation exist for type {0}", type));
            }
        }

        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            List<string> identifiers,
            bool exactMatch = false,
            int? amountOfTimes = null,
            RBT.BaseEnhancedPDF pdf = null,
            bool? bold = null,
            bool shouldExist = true)
        {
            foreach (string identifier in identifiers)
                if (VerifyObjectExistence(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }

        private bool VerifyCodingLevelExists(string codingLevel)
        {
            Dropdown codingLevelDropdown = Browser.TryFindElementByPartialID("LevelDDL").EnhanceAs<Dropdown>();
            return codingLevelDropdown.VerifyByText(codingLevel);
        }

        private bool VerifyPriority(string priorityLevel)
        {
            Textbox priorityTextBox = Browser.TryFindElementByPartialID("PriorityTXT").EnhanceAs<Textbox>();
            return priorityTextBox.GetText().Equals(priorityLevel, StringComparison.InvariantCultureIgnoreCase);
        }
        #endregion

        #region IVerifyRowsExist
        /// <summary>
        /// Implementation of IVerifyRowsExist for ArchitectCoderConfigPage
        /// </summary>
        /// <param name="tableIdentifier"></param>
        /// <param name="matchTable"></param>
        /// <returns></returns>
        public bool VerifyTableRowsExist(string tableIdentifier, Table matchTable, int? amountOfTimes = null)
        {
            string tableId = GetTableIdFromTableName(tableIdentifier);

            HtmlTable htmlTable = Browser.TryFindElementById(tableId).EnhanceAs<HtmlTable>();
            ReadOnlyCollection<IWebElement> matchTrs = htmlTable.FindMatchRows(matchTable);

            if (amountOfTimes.HasValue)
                return matchTrs.Count.Equals(matchTable.Rows.Count * amountOfTimes);
            else
                return matchTrs.Count == matchTable.Rows.Count;
        }
        #endregion

    }
}
