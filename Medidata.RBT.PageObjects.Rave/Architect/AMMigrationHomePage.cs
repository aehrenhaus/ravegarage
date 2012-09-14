﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
namespace Medidata.RBT.PageObjects.Rave
{
	public class AMMigrationHomePage : RavePageBase
	{
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Source CRF")
				return Browser.Dropdown("_ddlSimpleSourceVersionId");
			if (identifier == "Target CRF")
				return Browser.Dropdown("ddlSimpleTargetVersionId");
		
			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}


        public override IPage NavigateTo(string name)
        {
            if (name == "Execute Plan")
                return ClickLink("Execute Plan");

            return base.NavigateTo(name);
        }

        public override IPage ClickLink(string linkName)
        {
            base.ClickLink(linkName);
            if (linkName == "Create Plan")
                TestContext.CurrentPage = new AMMigrationHomePage();
            if (linkName == "Execute Plan")
                TestContext.CurrentPage = new AMMigrationExecutePage();

            return TestContext.CurrentPage;
        }

        /// <summary>
        /// Select the source crf
        /// </summary>
        /// <param name="sourceCRFName">The feature defined source crf name</param>
        public void SelectSourceCRF(string sourceCRFName)
        {
            string uniqueSourceCRFName = ((CrfVersion)TestContext.FeatureObjects[sourceCRFName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_MigrationStepStart1_ddlSimpleSourceVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueSourceCRFName);
        }

        /// <summary>
        /// Select the target crf
        /// </summary>
        /// <param name="sourceCRFName">The feature defined target crf name</param>
        public void SelectTargetCRF(string targetCRFName)
        {
            string uniqueTargetCRFName = ((CrfVersion)TestContext.FeatureObjects[targetCRFName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_MigrationStepStart1_ddlSimpleTargetVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueTargetCRFName);
        }

		public override string URL
		{
			get
			{
				return "Modules/AmendmentManager/MigrationHome.aspx";
			}
		}
	}
}
