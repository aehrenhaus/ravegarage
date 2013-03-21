using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{

	public class CodingColumnSettingPage : ConfigurationBasePage, IVerifySomethingExists, IVerifyRowsExist
    {
		public void EnterData(IEnumerable<CodingColumnModel> model)
		{
			var table = Browser.Table("_ctl0_Content_ColumnGrid");

			foreach (var row in model)
			{
				TechTalk.SpecFlow.Table query = new TechTalk.SpecFlow.Table("Column");
				query.AddRow(row.Column);

				var eleRowFound = table.FindMatchRows(query).FirstOrDefault();
				Assert.IsNotNull(eleRowFound,"Row not found: column="+row.Column);
				eleRowFound.TextboxById("TxtRecursiveDepth").SetText(row.RecursiveDepth);
			}
		}

		public void Save()
		{
			Browser.ButtonByID("ImgBtnSave").Click();
		}
      
        public override string URL
        {
            get
            {
				return "Modules/Configuration/CodingColumnSetting.aspx";
            }
        }

        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, RBT.BaseEnhancedPDF pdf = null, bool? bold = null)
		{
			if (type == "text")
			{
				string allText = Browser.FindElementByTagName("body").Text;
				return (allText.Contains(identifier));
			}

			return false;
		}

        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }

		public bool VerifyTableRowsExist(string tableIdentifier, TechTalk.SpecFlow.Table matchTable, int? amountOfTimes = null)
		{
			var eTable = Browser.Table("_ctl0_Content_ColumnGrid");
			var foundRows = eTable.FindMatchRows(matchTable, TdTextSelector);
			return foundRows.Count == matchTable.RowCount;

		}

		private string TdTextSelector(IWebElement td)
		{
			var textboxes = td.Textboxes(true,false);
			if (textboxes.Count != 0)
				return textboxes[0].Value.Trim();

			string text = td.Text.Trim();
			return text;
		}
	}
}
