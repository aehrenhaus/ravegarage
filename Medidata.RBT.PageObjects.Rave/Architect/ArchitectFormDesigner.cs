using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectFormDesignerPage : ArchitectBasePage, IActivatePage, IVerifySomethingExists
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

    
        public IPage ExpandEditChecks(string field = "")
        {
            if (!field.Equals(""))
                ClickEditForField(field);

            ClickExpandForFieldEditChecks();
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

            rows[0].FindImagebuttonByPartialId("_ImgBtnSelect").Click();
        }

        private void ClickExpandForFieldEditChecks()
        {
            Browser.Tables()[30].FindImagebuttons()[0].Click();
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

		bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch)
		{
            bool retVal = false;
			if (areaIdentifier == null)
			{
                if (type.Equals("button", StringComparison.InvariantCultureIgnoreCase))
                {
                    IWebElement buttonDiv = Browser.TryFindElementBy(By.XPath(string.Format("//div/input[@value='{0}']", identifier)));
                   
                    string visibility = buttonDiv.GetCssValue("visibility");
                    if (visibility.Equals("visible", StringComparison.InvariantCultureIgnoreCase))
                        retVal = true;
                }
                else if (string.IsNullOrEmpty(type) || type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
                {
                    if (!exactMatch && Browser.FindElementByTagName("body").Text.Contains(identifier))
					    retVal =  true;
                }

                return retVal;
			}
			throw new NotImplementedException();
		}

		#endregion
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
                dropDownElem.EnhanceAs<Dropdown>().SelectByText(text);
                return GetPageByCurrentUrlIfNoAlert();
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
        public void FillDataPoints(IEnumerable<FieldModel> fieldModels)
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
                    default:
                        {
                            throw new NotSupportedException("Not supported control type:" + controlType);
                        }
                }
            }

            //save the setting after filling the data points and wait for document load to finish before returning
            this.ClickLink("Save");
            Browser.WaitForDocumentLoad();
        }
    }
}
