﻿using System;
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
	public class PublishChecksHomePage : ArchitectBasePage
	{
		protected override IWebElement GetElementByName(string name)
		{
			if (name == "Current CRF Version")
				return Browser.Dropdown("ddlCurrentVersionId");
			if (name == "Reference CRF Version")
				return Browser.Dropdown("ddlReferenceVersionId");

			return base.GetElementByName(name);
		}

		public override IPage ChooseFromCheckboxes(string areaIdentifer, string identifer, bool isChecked)
		{
			var table = Browser.Table("dgObjects");
			Table filter = new Table("Name");
			filter.AddRow (areaIdentifer);
			var foundRow = table.FindMatchRows(filter);

			var chk = foundRow[0].Checkbox("chkSelectInactivate");

			chk.Check();

			return this;
		}

		public override string URL
		{
			get
			{
				return "Modules/PublishChecks/PublishChecksHome.aspx";
			}
		}
	}
}
