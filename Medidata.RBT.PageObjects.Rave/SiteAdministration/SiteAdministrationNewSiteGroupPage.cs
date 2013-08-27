﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.SiteAdministration
{
    public class SiteAdministrationNewSiteGroupPage : RavePageBase
    {
        public override string URL
        {
            get
            {
                return "Modules/SiteAdmin/SiteGroupPage.aspx";
            }
        }


        public void CreateSiteGroup(string Name)
        {
            Browser.FindElementById("_ctl0_Content_ImagebuttonInsert01").Click();
            Browser.TextboxById("_ctl0_Content_txtSiteGroupName").EnhanceAs<Textbox>().SetText(Name);
            Browser.FindElementById("_ctl0_Content_ImgBtnSave").Click();
        }
    }
}