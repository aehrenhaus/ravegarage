using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Collections.ObjectModel;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SharedObjects;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectFormDesignerPage : ArchitectBasePage, IActivatePage, IVerifySomethingExists, IExpand
	{
		#region IActivatePage

		public IPage Activate(string type, string identifierToActivate)
		{
			Activate(identifierToActivate, true);
			return this;
		}

		public IPage Inactivate(string type, string identifierToInactivate)
		{
			Activate(identifierToInactivate, false);
			return this;
		}
        
        public IPage EditField(string field)
        {
            ClickEditForField(field);
            return this;  
        }

        public IPage FillRangesForFieldEditChecks(IEnumerable<FieldModel> fields)
		{
            foreach (var field in fields)
                UpdateFieldEditCheckRanges(field.FieldEditCheck, field.Low, field.High);
			return this;
		}

      

        public bool VerifyRangesForFieldEditChecks(IEnumerable<FieldModel> fields)
        {
            foreach (var field in fields)
            {
                if (!VerifyFieldEditCheckRanges(field.FieldEditCheck, field.Low, field.High))
                    return false;
            }
            return true;
        }

        public IPage Save()
        {
            Browser.Tables()[10].FindImagebuttons()[0].Click();
            return this;
        }

    
        private IPage ExpandEditChecks(string field = "")
        {
            if (!field.Equals(""))
                ClickEditForField(field);

            ClickExpandForFieldEditChecks();
            return this;
        }

        private IPage ExpandViewRestrictions(string field = "")
        {
            if (!field.Equals(""))
                ClickEditForField(field);

            ClickExpandViewRestrictions();
            return this;
        }

        private IPage ExpandEntryRestrictions(string field = "")
        {
            if (!field.Equals(""))
                ClickEditForField(field);

            ClickExpandEntryRestrictions();
            return this;
        }

        private bool VerifyFieldEditCheckRanges(string editCheckType, string lowValue, string highValue)
        {
            int index = 0;
            if (editCheckType.Trim().Equals("Auto-Query for data out of range"))
            {
                //do nothing
            }
            else if (editCheckType.Trim().Equals("Mark non-conformant data out of range"))
            {
                index += 2;
            }
            else
            {
                throw new NotSupportedException(editCheckType + " not supported in UpdateFieldEditCheckRanges() in ArchitectFormDesigner.");
            }

            var table = Browser.Tables()[30];

            if ((!table.Textboxes()[index].Value.Equals(lowValue)) || (!table.Textboxes()[index + 1].Value.Equals(highValue)))
                return false;
            return true;
        }

        private void UpdateFieldEditCheckRanges(string editCheckType, string lowValue, string highValue)
        {
            int index = 0;
            if (editCheckType.Trim().Equals("Auto-Query for data out of range"))
            {
                //do nothing
            }
            else if (editCheckType.Trim().Equals("Mark non-conformant data out of range"))
            {
                index +=2;
            }
            else
            {
                throw new NotSupportedException(editCheckType + " not supported in UpdateFieldEditCheckRanges() in ArchitectFormDesigner.");
            }
            
            var table = Browser.Tables()[30];

            table.Textboxes()[index].SetText(lowValue);
            table.Textboxes()[index + 1].SetText(highValue);
        }

        private void ClickEditForField(string field)
        {
            var table = Browser.Table("_ctl0_Content_FieldsGrid");
			Table matchTable = new Table("Name");
            matchTable.AddRow(field);
            var rows = table.FindMatchRows(matchTable);

            if (rows.Count == 0)
                throw new Exception("Can't find target to see field for:" + field);

            rows[0].TryFindElementByPartialID("ImgBtnSelect").Click();
        }

        private void ClickExpandForFieldEditChecks()
        {
            Browser.Tables()[30].FindImagebuttons()[0].Click();
        }
        
        private void ClickExpandViewRestrictions()
        {
            Browser.Tables()[38].FindImagebuttons()[0].Click();
        }

        private void ClickExpandEntryRestrictions()
        {
            Browser.Tables()[43].FindImagebuttons()[0].Click();
        }

		private void Activate(string identifier, bool activate)
		{
            throw new NotImplementedException("Activate method not implemented in ArchitectFormDesigner.cs.");
		}

		#endregion

		public override string URL
		{
			get
			{
                return "Modules/Architect/FormDesigner.aspx";
			}
		}

		#region IVerifySomethingExists

        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
		{
            bool retVal = false;
            if (areaIdentifier == null)
            {
                if (type.Equals("button", StringComparison.InvariantCultureIgnoreCase))
                {
                    IWebElement buttonDiv = Browser.TryFindElementBy(By.XPath(string.Format("//div/input[@value='{0}']", identifier)));

                    if (buttonDiv == null)
                        return false;
                    string visibility = buttonDiv.GetCssValue("visibility");
                    if (visibility.Equals("visible", StringComparison.InvariantCultureIgnoreCase))
                        retVal = true;
                }
                else if (type.Equals("field", StringComparison.InvariantCultureIgnoreCase))
                {
                    IWebElement fieldsGrid = Browser.TryFindElementByPartialID("FieldsGrid");
                    return fieldsGrid.TryFindElementBySpanLinktext(identifier) != null;
                }
                else if (type.Equals("button", StringComparison.InvariantCultureIgnoreCase))
                {
                    IWebElement button = Browser.TryFindElementByXPath(".//input[contains(text(), '" + identifier + "')]");
                    return button != null;
                }
                else if (string.IsNullOrEmpty(type) || type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
                {
                    if (!exactMatch && Browser.FindElementByTagName("body").Text.Contains(identifier))
                        retVal = true;
                }

                return retVal;
            }
            else
            {
                if (type.Equals("field", StringComparison.InvariantCultureIgnoreCase))
                    return CheckFields(identifier, areaIdentifier);
            }
			throw new NotImplementedException();
		}

        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }

        /// <summary>
        /// Check that a field exists with the passed in name and oid
        /// </summary>
        /// <param name="fieldName">The field name to check for</param>
        /// <param name="fieldOID">The field oid to check for</param>
        /// <returns>True if the field is there, false if it is not</returns>
        private bool CheckFields(string fieldName, string fieldOID)
        {
            ReadOnlyCollection<IWebElement> fieldRowsAtStart = Browser.TryFindElementByPartialID("FieldsGrid").TryFindElementsBy(By.XPath(".//td/span[contains(text(), '" + fieldName +"')]/../.."));

            //Cant use foreach here because the Click method causes stale element reference, must get the rows each time
            for (int i = 0; i < fieldRowsAtStart.Count; i++)
            {
                ReadOnlyCollection<IWebElement> fieldRowsRefresh = Browser.TryFindElementByPartialID("FieldsGrid").TryFindElementsBy(By.XPath(".//td/span[contains(text(), '" + fieldName + "')]/../.."));
                if (CheckFieldHasOID(fieldRowsRefresh[i], fieldOID))
                    return true;
            }

            return false;
        }

        /// <summary>
        /// Check that a specific field has the passed in fieldOID
        /// </summary>
        /// <param name="fieldRow">The row in the fields table to click edit on to check</param>
        /// <param name="fieldOID">The field OID we are looking to match</param>
        /// <returns>True if the field passed in (represented by the fieldRow) has the correct field OID, false otherwise</returns>
        private bool CheckFieldHasOID(IWebElement fieldRow, string fieldOID)
        {
            //Click edit button, can't use existing method because that would click the first edit button on a field matching the name (there could be multiples in this case)
            fieldRow.TryFindElementByPartialID("ImgBtnSelect").Click();
            return Browser.TryFindElementById("FDC_txtFieldOID").GetAttribute("value").Trim().Equals(fieldOID.Trim());
        }

		#endregion


        /// <summary>
        /// Clicks the preview.
        /// </summary>
        /// <returns></returns>
        public IPage ClickPreview()
        {
            IWebElement link = SearchContext.TryFindElementById("_ctl0_Content_PreviewLnk");
            link.Click();
            return this;  
        }


        /// <summary>
        /// Overriding ChooseFromDropdown to find the dropdown based on field name, if drop down selected fails then fall back to base implementation
        /// </summary>
        /// <param name="identifier"></param>
        /// <param name="text"></param>
        /// <param name="objectType"></param>
        /// <param name="areaIdentifier"></param>
        /// <returns></returns>
        public override IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
            //try finding the tr corresponding to the identifier which is architect field variable name
            IWebElement elem = TryFindTrByFieldSettingName(identifier);
            //Try finding the dropdown withing the tr
            IWebElement dropDownElem = null;
            if (elem != null)
            {
                dropDownElem = elem.TryFindElementByXPath(".//select");
            }

            if (dropDownElem != null)
            {
                if (identifier.Equals("Coding Dictionary:", StringComparison.InvariantCultureIgnoreCase) && 
                    text.StartsWith("CODER- ", StringComparison.InvariantCultureIgnoreCase))
                {
                    string codingDictionaryName = text.Replace("CODER- ", "");
                    codingDictionaryName = SeedingContext.GetExistingFeatureObjectOrMakeNew<CodingDictionary>(codingDictionaryName,
                        () => { throw new Exception(string.Format("Coding Dictionary [{0}] not found", codingDictionaryName)); }).UniqueName;
                    text = string.Format("CODER- {0}", codingDictionaryName);
                }
                else if (identifier.Equals("Coding Dictionary:", StringComparison.InvariantCultureIgnoreCase) &&
                    text.StartsWith("Rave- ", StringComparison.InvariantCultureIgnoreCase))
                {
                    string codingDictionaryName = text.Replace("Rave- ", "");
                    ClassicCodingDictionary ccd = SeedingContext.GetExistingFeatureObjectOrMakeNew<ClassicCodingDictionary>(codingDictionaryName,
                        () => { throw new Exception(string.Format("Classic Coding Dictionary [{0}] not found", codingDictionaryName)); });
                    text = string.Format("Rave- {0} Version: {1}", ccd.UniqueName, ccd.DictionaryVersion);
                }

                dropDownElem.EnhanceAs<Dropdown>().SelectByText(text);
                return WaitForPageLoads();
            }
            else
                return base.ChooseFromDropdown(identifier, text, objectType, areaIdentifier);
        }

        /// <summary>
        /// Method to set the field text based for architect field variable
        /// </summary>
        /// <param name="identifier">Identifier should be the field variable name</param>
        /// <param name="text">Text to set for the field</param>
        public void SetFieldText(string identifier, string text)
        {
            //try finding the tr corresponding to the identifier which is architect field variable name
            IWebElement elem = TryFindTrByFieldSettingName(identifier);

            if (elem != null)
            {
                IWebElement textFieldElem = elem.TryFindElementByXPath(".//input");
                textFieldElem.EnhanceAs<Textbox>().SetText(text);
            }
        }

        /// <summary>
        /// Helper method to find the tr corresponding the architect field variable based on field setting name
        /// </summary>
        /// <param name="settingName">Name of the architect field setting</param>
        /// <returns></returns>
        private IWebElement TryFindTrByFieldSettingName(string settingName)
        {
            IWebElement elem = Browser.TryFindElementsBy(By.XPath("//tr")).FirstOrDefault(e => e.Text.StartsWith(settingName));
            return elem;
        }

        /// <summary>
        /// Method to fill the Architect field setting related data points
        /// </summary>
        /// <param name="fieldModels"></param>
        public void FillFieldProperties(IEnumerable<FieldModel> fieldModels, bool save =true)
        {
            //This method support filling dropdowns and textbox data so far and should be extended in future if 
            //support for other control type is needed.
            foreach (FieldModel fm in fieldModels)
            {
                ControlType controlType = EnumHelper.GetEnumByDescription<ControlType>(fm.ControlType);

                switch (controlType)
                {
                    case ControlType.Text:
                        {
                            SetFieldText(fm.Field, fm.Data);
                            break;
                        }
                    case ControlType.DropDownList:
                        {
                            ChooseFromDropdown(fm.Field, fm.Data);
                            break;
                        }
                    case  ControlType.TextArea:
                        {
                            if (String.Compare(fm.Field, "Field Label", StringComparison.CurrentCultureIgnoreCase) == 0)
                            {
                                var txt = Browser.TextareaById("txtFieldLabel");
                                txt.SetText(fm.Data);
                                break;
                            }
                            throw new NotSupportedException("Not supported control type:" + controlType);
                        }
                    default:
                        {
                            throw new NotSupportedException("Not supported control type:" + controlType);
                        }
                }
            }
            if (save)
            {
                //save the setting after filling the data points and wait for document load to finish before returning
                this.ClickLink("Save");
                Browser.WaitForDocumentLoad();
            }
            
        }

        /// <summary>
        /// Verify that a field with the passed in name has the passed in coding dictionary
        /// </summary>
        /// <param name="fieldName">The name of the field</param>
        /// <param name="codingDictionary">The name of the coding dictionary, should be the unqiue version</param>
        /// <returns>True if the field has the coding dictionary, false otherwise</returns>
        public bool VerifyCodingDictionaryForField(string fieldName, string codingDictionary)
        {
            ClickEditForField(fieldName);
            return VerifyCodingDictionary(codingDictionary);
        }

        /// <summary>
        /// Verify the coding dictionary we are looking for appears in the coding dictionary dropdown
        /// </summary>
        /// <param name="codingDictionary">The unique name of the coding dictionary</param>
        /// <returns>True if the coding dictionary is in the coding dictionary dropdown, false otherwise</returns>
        public bool VerifyCodingDictionary(string codingDictionary)
        {
            SelectElement selectedCodingDictionaryElement = new SelectElement(Browser.TryFindElementByPartialID("ddlCodingDictionary"));
            string uniqueCodingDictionaryName = SeedingContext.GetExistingFeatureObjectOrMakeNew<ISeedableObject>(codingDictionary,
                () => { throw new Exception(string.Format("Specified coding dictionary [{0}] is not available in seeded object", codingDictionary)); }).UniqueName;

            return selectedCodingDictionaryElement.SelectedOption.Text.Contains(uniqueCodingDictionaryName);
        }

        public override IPage ChooseFromCheckboxes(string identifier, bool isChecked = true, string areaIdentifier = null, string listItem = null)
        {
            IPage result = null;

            if ("Auto-Query for non-conformant data".Equals(identifier))
            {
                result = base.ChooseFromCheckboxes(
                    "_chkNonConform", isChecked);
            }

            return result;
        }


        public void SetFieldEntryRestriction(string role, bool selected)
        {
            Checkbox roleCheckbox = new Checkbox();
            var table = Browser.FindElement(By.XPath("//table[@id = '_ctl0_Content_ERC_cblEntryRestrictions']")).Children()[0];
            foreach (var tableRow in table.Children())
            {
                if (tableRow.Children()[0].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[0].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[1].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[1].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[2].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[2].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }
            }
            if (selected)
                roleCheckbox.EnhanceAs<Checkbox>().Check();
            else
                roleCheckbox.EnhanceAs<Checkbox>().Uncheck();
        }

        public void SetFieldViewRestriction(string role, bool selected)
        {
            Checkbox roleCheckbox = new Checkbox();
            var table = Browser.FindElement(By.XPath("//table[@id = '_ctl0_Content_VRC_cblViewRestrictions']")).Children()[0];
            foreach (var tableRow in table.Children())
            {
                if (tableRow.Children()[0].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[0].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[1].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[1].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[2].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[2].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }
            }

            if (selected)
                roleCheckbox.EnhanceAs<Checkbox>().Check();
            else
                roleCheckbox.EnhanceAs<Checkbox>().Uncheck();
        }

        #region IExpand_interface
        /// <summary>
        /// Use this method to expand any control on Architect Form Designer page
        /// Relevant support should be added based on need.
        /// </summary>
        /// <param name="objectToExpand"></param>
        /// <param name="areaIdentifier"></param>
        public void Expand(string objectToExpand, string areaIdentifier = null)
        {
            if (objectToExpand.Equals("Field Edit Checks", StringComparison.InvariantCultureIgnoreCase))
            {
                ExpandEditChecks();
            }
            else if (objectToExpand.Equals("Entry Restrictions", StringComparison.InvariantCultureIgnoreCase))
            {
                ExpandEntryRestrictions();
            }
            else if (objectToExpand.Equals("View Restrictions", StringComparison.InvariantCultureIgnoreCase))
            {
                ExpandViewRestrictions();
            }
            else
                throw new NotImplementedException(string.Format("Method currently does not support expand for {0}", objectToExpand));
        }
        #endregion
    }
}
