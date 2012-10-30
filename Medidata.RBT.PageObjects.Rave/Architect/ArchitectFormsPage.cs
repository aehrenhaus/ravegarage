using System;
using System.Linq;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
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

        private void SelectFields(string form)
        {
            var dummy = Browser.WaitForElement("_ctl0_Content_FormGrid");  // wait for page to load.

            var table = Browser.Table("_ctl0_Content_FormGrid");
            Table matchTable = new Table("Form UniqueName");
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
            Table matchTable = new Table("Form UniqueName");
			matchTable.AddRow(identifier);
			var rows = table.FindMatchRows(matchTable);

			if (rows.Count == 0)
				throw new Exception("Can't find target to inactivate:"+identifier);

			rows[0].Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();

			//redo ,because page refreshed
            matchTable = new Table("Form UniqueName");
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
	}
}
