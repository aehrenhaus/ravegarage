using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectChecksPage : ArchitectBasePage, IActivatePage
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

        // TODO limit search (see ArchitectFormsPage)
		private void Activate(string identifier, bool activate)
		{
			var table = Browser.Table("_ctl0_Content_DisplayGrid");
			Table matchTable = new Table("Name");
			matchTable.AddRow(identifier);
			var rows = table.FindMatchRows(matchTable);

			if (rows.Count == 0)
				throw new Exception("Can't find target to inactivate:"+identifier);

			rows[0].Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();

			//redo ,because page refreshed
			matchTable = new Table("Name");
			matchTable.AddRow("");//because it's text box, Text property is ""
			table = Browser.Table("_ctl0_Content_DisplayGrid");
			rows = table.FindMatchRows(matchTable);

			if(activate)
				rows[0].CheckboxByID("Active").Check();
			else
				rows[0].CheckboxByID("Active").Uncheck();
			rows[0].Link("  Update").Click();
		}

        #endregion

        /// <summary>
        /// Method to add a new Edit Check(s)
        /// </summary>
        /// <param name="editChecks"></param>
        public void AddEditCheck(IEnumerable<EditCheckModel> editChecks)
        {
            foreach (var ec in editChecks)
            {
                IWebElement eTable = this.Browser.TryFindElementById("_ctl0_Content_DisplayGrid");
                IWebElement eName = eTable.TryFindElementsBy(By.TagName("input"))[0];
                eName.EnhanceAs<Textbox>().SetText(ec.Name);
                IWebElement eBypassDuringMigration = eTable.TryFindElementsBy(By.TagName("input"))[1];
                if (ec.BypassDuringMigration)
                    eBypassDuringMigration.EnhanceAs<Checkbox>().Check();
                else
                    eBypassDuringMigration.EnhanceAs<Checkbox>().Uncheck();
                IWebElement eActive = eTable.TryFindElementsBy(By.TagName("input"))[2];
                if (ec.Active)
                    eActive.EnhanceAs<Checkbox>().Check();
                else
                    eActive.EnhanceAs<Checkbox>().Uncheck();
                IWebElement eUpdate = eTable.TryFindElementBy(By.PartialLinkText("Update"));
                eUpdate.Click();
             }
        }

        /// <summary>
        /// Method to edit Edit Check
        /// </summary>
        /// <param name="iconName"></param>
        ///  <param name="editCheckName"></param>
        public void EditEditCheck(string iconName, string editCheckName)
        {
            IWebElement eRow = this.Browser.TryFindElementById("_ctl0_Content_DisplayGrid").TryFindElementByXPath(string.Format("//*[contains(text(),'{0}')]/..",editCheckName));
            IWebElement eEdit = eRow.TryFindElementBy(By.PartialLinkText("javascript:__doPostBack"));
            IWebElement eCheckSteps = eRow.TryFindElementByPartialID("_CheckDetailsLink");
            if (iconName == "Edit")
                eEdit.Click();
            if (iconName == "Check Steps")
                eCheckSteps.Click();
        }

		public override string URL
		{
			get
			{
				return "Modules/Architect/Checks.aspx";
			}
		}
	}
}
