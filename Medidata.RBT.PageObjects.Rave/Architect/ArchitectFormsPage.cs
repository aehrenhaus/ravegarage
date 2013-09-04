using System;
using System.Linq;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
using System.Collections.Generic;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectFormsPage : ArchitectBasePage, IActivatePage
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


        public IPage SelectFieldsForForm(string form)
        {
            SelectFields(form);
            return new ArchitectFormDesignerPage();
        }


        public IPage SearchForForm(string form)
        {
            Browser.Textboxes()[0].SetText(form);
            Browser.Keyboard.PressKey("\n");
            return this;
        }

        public override IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
            //try finding the tr corresponding to the identifier which is architect form name
            IWebElement elem = TryFindTrByFieldSettingName(identifier);
            //Try finding the dropdown withing the tr
            IWebElement dropDownElem = null;
            if (elem != null)
            {
                dropDownElem = elem.TryFindElementByXPath(".//select");

                dropDownElem.EnhanceAs<Dropdown>().SelectByText(text);
                return WaitForPageLoads();
            }
            else
                return base.ChooseFromDropdown(identifier, text, objectType, areaIdentifier);
        }

        private void SelectFields(string form)
        {
            var dummy = Browser.TryFindElementById("_ctl0_Content_FormGrid");  // wait for page to load.

            var table = Browser.Table("_ctl0_Content_FormGrid");
            Table matchTable = new Table("Form Name");
            matchTable.AddRow(form);
            var rows = table.FindMatchRows(matchTable);

            if (rows.Count == 0)
                throw new Exception("Can't find target to see fields for:" + form);

            rows[0].Images().First(x => x.GetAttribute("src").EndsWith("i_cdrill.gif")).Click();
        }

		private void Activate(string identifier, bool activate)
		{
            Browser.Textboxes()[0].SetText(identifier);
            Browser.Keyboard.PressKey("\n");

            var table = Browser.Table("_ctl0_Content_FormGrid");
            Table matchTable = new Table("Form Name");
			matchTable.AddRow(identifier);
			var rows = table.FindMatchRows(matchTable);

			if (rows.Count == 0)
				throw new Exception("Can't find target to inactivate:"+identifier);

			rows[0].Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();

			//redo ,because page refreshed
            matchTable = new Table("Form Name");
			matchTable.AddRow("");//because it's text box, Text property is ""
            table = Browser.Table("_ctl0_Content_FormGrid");
			rows = table.FindMatchRows(matchTable);

			if(activate)
				rows[0].CheckboxByID("Active").Check();
			else
				rows[0].CheckboxByID("Active").Uncheck();
			rows[0].Link("  Update").Click();
		}

		#endregion

		public override string URL
		{
			get
			{
                return "Modules/Architect/FormsPage.aspx";
			}
		}

        /// <summary>
        /// This method allows to fill the fields for new form to be added in architect followed by saving it
        /// </summary>
        /// <param name="formModel"></param>
        public void FillFormProperties(ArchitectFormModel formModel)
        {
            //Note: currently supports adding form name, oid and active fields and should be extended in future based on need
            if (!string.IsNullOrWhiteSpace(formModel.FormName))
                FillFormName(formModel.FormName);

            if (!string.IsNullOrWhiteSpace(formModel.OID))
                FillFormOID(formModel.OID);

            if (formModel.Active.HasValue)
                FillFormActive(formModel.Active.Value);


            Browser.TryFindElementByLinkText("  Update").Click();
            WaitForPageLoads();
        }

        /// <summary>
        /// Allows entering form name for the form field in architect form open for editing
        /// </summary>
        /// <param name="formName"></param>
        public void FillFormName(string formName)
        {
            Browser.TryFindInputElementByPartialID<Textbox>("text", "_Name").
                    SetText(formName);
        }

        /// <summary>
        /// Allows entering form oid for the form field in architect form open for editing
        /// </summary>
        /// <param name="formOid"></param>
        public void FillFormOID(string formOid)
        {
            Browser.TryFindInputElementByPartialID<Textbox>("text", "_txtOID").
                    SetText(formOid);
        }

        /// <summary>
        /// Allows entering form active for the form field in architect form open for editing
        /// </summary>
        /// <param name="active"></param>
        public void FillFormActive(bool active)
        {
            Checkbox validateChkBox = Browser.TryFindInputElementByPartialID<Checkbox>("checkbox", "_FormActive");

            if (active)
                validateChkBox.Check();
            else
                validateChkBox.Uncheck();
        }
    }
}
