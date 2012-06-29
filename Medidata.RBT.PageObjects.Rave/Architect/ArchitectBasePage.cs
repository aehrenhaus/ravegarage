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
	public class ArchitectBasePage : RavePageBase
	{
		protected override IPage GetTargetPageObjectByLinkAreaName(string type, string areaName)
		{
			if (type == "Draft" && areaName == "Header")
				return new ArchitectCRFDraftPage();
			if (type == "Study" && areaName == "Header")
				return new ArchitectLibraryPage();

			return base.GetTargetPageObjectByLinkAreaName(type, areaName);
		}
	}
}
