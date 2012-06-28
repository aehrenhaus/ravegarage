using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectPage : RavePageBase
	{
		protected override IWebElement GetElementByName(string name)
		{
			if (name == "Active Projects")
				return Browser.Table("_ctl0_Content_ProjectGrid");
			if (name == "Inactive Projects")
				return Browser.Table("_ctl0_Content_InactiveProjectGrid");

			return base.GetElementByName(name);
		}

		protected override IPage GetTargetPageObjectByLinkAreaName(string areaName)
		{
			if (areaName == "Active Projects" || areaName == "Inactive Projects")
			{
				return new ArchitectLibraryPage();
			}
			
			return base.GetTargetPageObjectByLinkAreaName(areaName);
		}

		public override IPage ClickLink(string linkText)
		{
			base.ClickLink(linkText);

			if (linkText == "Add New Draft")
				return new ArchitectNewDraftPage();

			return this;
		}
	}
}
