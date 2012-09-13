using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.AmendmentManager
{
	public class AmendmentManagerHomePage : RavePageBase
	{
        public AmendmentManagerHomePage()
		{
			PageFactory.InitElements(Browser, this);
		}

        /// <summary>
        /// Navigate to a study
        /// </summary>
        /// <param name="studyName">Feature defined study name</param>
        public void NavigateToStudy(string studyName)
        {
            TestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(new Project(studyName).UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().NavigateTo("Amendment Manager");
        }

        public override string URL { get { return "Modules/AmendmentManager/MigrationHome.aspx"; } }
	}
}
