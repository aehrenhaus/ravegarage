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
        /// <summary>
        /// Publish a crf
        /// </summary>
        /// <param name="crfVersion">The unique name of the crf to publish</param>
        /// <returns>This page</returns>
		public ArchitectCRFDraftPage PublishCRF(string crfVersion)
		{
			Type("_ctl0_Content_TxtCRFVersion", crfVersion);
			ClickButton("Publish to CRF Version");
			return this;
		}


		public override IPage NavigateTo(string name)
		{
			if (name == "Edit Checks")
			{
				Browser.TryFindElementById("TblOuter").Link(name).Click();
		
				return new ArchitectChecksPage();
			}


            if (name == "Forms")
            {
                Browser.TryFindElementById("TblOuter").Link(name).Click();

                return new ArchitectFormsPage();
            }


			return base.NavigateTo(name);
		}

        public override IPage ClickLink(string linkText)
        {
            base.ClickLink(linkText);

            if (linkText == "Restrictions")
                TestContext.CurrentPage = new ArchitectNewDraftPage();

            return TestContext.CurrentPage;
        }

		public override string GetInfomation(string identifier)
		{
			if (identifier == "crfversion")
				return GetLatestCRFVersion();
			return base.GetInfomation(identifier);
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
