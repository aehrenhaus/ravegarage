using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectChecksPage : ArchitectBasePage, IActivatePage
	{
		#region IActivatePage

		public IPage Activate(string type, string identiferToActivate)
		{
			Activate(identiferToActivate, true);


			return this;
		}

		public IPage Inactivate(string type, string identiferToInactivate)
		{
			Activate(identiferToInactivate, false);


			return this;
		}

		private void Activate(string identifer, bool activate)
		{
			var table = Browser.Table("_ctl0_Content_DisplayGrid");
			Table matchTable = new Table("Name");
			matchTable.AddRow(identifer);
			var rows = table.FindMatchRows(matchTable);

			if (rows.Count == 0)
				throw new Exception("Can't find target to inactivate:"+identifer);

			rows[0].Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();

			//redo ,because page refreshed
			matchTable = new Table("Name");
			matchTable.AddRow("");//because it's text box, Text property is ""
			table = Browser.Table("_ctl0_Content_DisplayGrid");
			rows = table.FindMatchRows(matchTable);

			if(activate)
				rows[0].Checkbox("Active").Check();
			else
				rows[0].Checkbox("Active").Uncheck();
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
