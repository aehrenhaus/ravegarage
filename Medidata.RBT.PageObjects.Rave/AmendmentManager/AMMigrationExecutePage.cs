using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
namespace Medidata.RBT.PageObjects.Rave.AmendmentManager
{
	public class AMMigrationExecutePage : RavePageBase
	{
        [FindsBy(How = How.Id, Using = "_ctl0_Content_MigrationStepOptions1_dgSelect__ctl1_txtSubject")]
        public IWebElement SubjectNameBox;

		public AMMigrationExecutePage Migrate()
		{
			ChooseFromRadiobuttons(null, "rblMigrationMode_0");
	
			Browser.TryFindElementByPartialID("CRFDraftsLabel");
			Browser.Div("pnlSubjects").Link("All").Click();
			Browser.Link("Migrate").Click();
			return this;
		}

        /// <summary>
        /// Migrate a specific subject
        /// </summary>
        /// <param name="subjectSearchString">Subject to migrate</param>
        /// <returns>The AMMigrationExecutePage with the migrations occuring</returns>
        public AMMigrationExecutePage Migrate(string subjectSearchString)
        {
            ChooseFromRadiobuttons(null, "rblMigrationMode_0");

            Browser.TryFindElementByPartialID("CRFDraftsLabel");
            SubjectNameBox.EnhanceAs<Textbox>().SetText(subjectSearchString);
            ClickLink("Search");
            IWebElement selectedSubject = Browser.TryFindElementByOptionText(subjectSearchString,true);
            selectedSubject.Click();
            ClickLink("Add Subject");

            Browser.Link("Migrate").Click();
            return this;
        }

		public override string URL
		{
			get
			{
				return "Modules/AmendmentManager/MigrationExecute.aspx";
			}
		}

	}
}
