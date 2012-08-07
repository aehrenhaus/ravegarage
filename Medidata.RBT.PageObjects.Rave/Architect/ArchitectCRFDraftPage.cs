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
	public class ArchitectCRFDraftPage : ArchitectBasePage
	{
		public ArchitectCRFDraftPage PublishCRF(string crfVersion)
		{
			Type("_ctl0_Content_TxtCRFVersion", crfVersion);
			ClickButton("Publish to CRF Version");
			return this;
		}

		public override IWebElement GetElementByName(string name)
		{
			
			return base.GetElementByName(name);
		}

		public override IPage NavigateTo(string name)
		{

			if (name == "Edit Checks")
			{
				Browser.TryFindElementById("TblOuter").Link(name).Click();
		
				return new ArchitectChecksPage();
			}

			return base.NavigateTo(name);
		}

		public override string GetInfomation(string identifer)
		{
			if (identifer == "crfversion")
				return GetLatestCRFVersion();
			return base.GetInfomation(identifer);
		}


		public string GetLatestCRFVersion()
		{
			var trs = Browser.Table("VersionGrid").Children()[0].Children();
			var tr = trs[1];
			var td = tr.Children()[0];
			var text = td.Text.Trim();
			return text;
		}

		public override string URL
		{
			get
			{
				return "Modules/Architect/CrfDraftPage.aspx";
			}
		}
	
	}
}
