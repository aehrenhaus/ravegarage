﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
    public class SubjectOverridePage : RavePageBase
	{
		protected override IWebElement GetElementByName(string name)
		{
			if (name == "Search")
				return Browser.FindElementById("_ctl0_Content_HeaderControl_SearchLabel");
			return base.GetElementByName(name);
		}

		public override IPage ChooseFromDropdown(string name, string text)
		{
			if (name == "Select Site")
			{
				Browser.Textbox("_ctl0_Content_HeaderControl_slSite_TxtBx").SetText(text);
			}
			return this;
		}
	}
}
