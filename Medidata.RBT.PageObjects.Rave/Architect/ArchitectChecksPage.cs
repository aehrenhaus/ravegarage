﻿using System;
using System.Linq;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
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

		public override string URL
		{
			get
			{
				return "Modules/Architect/Checks.aspx";
			}
		}
	}
}
