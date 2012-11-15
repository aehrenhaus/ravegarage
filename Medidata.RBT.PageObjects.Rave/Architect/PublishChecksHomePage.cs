using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.Architect;
namespace Medidata.RBT.PageObjects.Rave
{
	public class PublishChecksHomePage : ArchitectBasePage
	{
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Current CRF Version")
				return Browser.DropdownById("ddlCurrentVersionId");
			if (identifier == "Reference CRF Version")
				return Browser.DropdownById("ddlReferenceVersionId");

			return base.GetElementByName(identifier, areaIdentifier,listItem);
		}


		public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
		{
            IPage result;
            
            if ("Show Field Edit Checks".Equals(identifier))
            {
                result = base.ChooseFromCheckboxes(
                    "_ctl0_Content_chkShowSystem", isChecked);
            }
            else
            {
                var table = Browser.Table("dgObjects");
                Table filter = new Table("Name");
                filter.AddRow(areaIdentifier);
                var foundRow = table.FindMatchRows(filter);

                string id = (identifier == "Inactivate") ? "chkSelectInactivate" : "chkSelectCopy";

                var chk = foundRow[0].CheckboxByID(id);

                chk.Check();

                result = this;
            }

            return result;
		}

        public override IPage ClickLink(string linkText, string type = null, string areaIdentifier = null)
        {
            var page = base.ClickLink(linkText, type, areaIdentifier);
            
            if ("Publish".Equals(linkText))
            {
                try
                {
                    this.GetAlertWindow().Accept();
                }
                catch { }
            }

            return page;
        }

        public void NavigateToStudy(string studyName)
        {
            TestContext.CurrentPage = new ArchitectPage().NavigateToSelf();
            Project project = TestContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName));
            TestContext.CurrentPage.As<ArchitectPage>().ClickProject(project.UniqueName);
            TestContext.CurrentPage.As<ArchitectLibraryPage>().NavigateTo("Publish Checks");
            TestContext.CurrentPage = this;
        }

		public override string URL
		{
			get
			{
				return "Modules/PublishChecks/PublishChecksHome.aspx";
			}
		}



        public PublishChecksEditChecksControl EditChecks
        {
            get { return new PublishChecksEditChecksControl(this); }
        }



        public void SelectCurrentCRF(string currentCrfName)
        {
            string uniqueSourceCRFName = ((CrfVersion)TestContext.SeedableObjects[currentCrfName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_ddlCurrentVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueSourceCRFName);
        }

        public void SelectReferenceCRF(string referenceCrfName)
        {
            string uniqueTargetCRFName = ((CrfVersion)TestContext.SeedableObjects[referenceCrfName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_ddlReferenceVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueTargetCRFName);
        }
    }
}
