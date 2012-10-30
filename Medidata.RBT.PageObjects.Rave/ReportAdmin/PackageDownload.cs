using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Reflection;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using TechTalk.SpecFlow;
namespace Medidata.RBT.PageObjects.Rave
{
	public class PackageDownloadPage : RavePageBase
	{
		public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
		{
			var table = Browser.Table("MainGrid");
			Table filter = new Table("Report UniqueName");
			filter.AddRow(listItem);
			var foundRow = table.FindMatchRows(filter);

			var chk = foundRow[0].Checkboxes()[0];

			chk.Check();

			return this;
		}

		public override string URL { get { return "Modules/ReportAdmin/PackageDownload.aspx"; } }

	}
}
