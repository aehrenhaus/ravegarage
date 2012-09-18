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
	public class ArchitectPage : ArchitectBasePage
	{
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Active Projects")
				return Browser.Table("_ctl0_Content_ProjectGrid");
			else if (identifier == "Inactive Projects")
				return Browser.Table("_ctl0_Content_InactiveProjectGrid");
            else if (identifier == "Active Global Library Volumes")
                return Browser.Table("_ctl0_Content_LibraryGrid");
            else if (identifier == "Proposed Global Library Volumes")
                return Browser.Table("_ctl0_Content_ProposedLibraryGrid");

			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}

		public override IPage ClickLink(string linkText)
		{
			base.ClickLink(linkText);

            if (linkText == "Add New Draft")
                TestContext.CurrentPage = new ArchitectNewDraftPage();

            if (linkText == "Upload Draft")
                TestContext.CurrentPage = new UploadDraftPage();

			return TestContext.CurrentPage;
		}

        /// <summary>
        /// Click a project on the architect page
        /// </summary>
        /// <param name="projectName">Unique name of the project to click</param>
        /// <returns>The current page, which will be an ArchitectLibraryPage</returns>
        public IPage ClickProject(string projectName)
        {
            base.ClickLink(projectName);
            TestContext.CurrentPage = new ArchitectLibraryPage();
            return TestContext.CurrentPage;
        }

		public override string URL
		{
			get
			{
				return "Modules/Architect/Architect.aspx";
			}
		}
	}
}
