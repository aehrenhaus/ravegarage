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

		public override IPage ClickLink(string linkText, string type = null, string areaIdentifier = null, bool partial = false)
        {
            IPage page = null;

            if ("Publish".Equals(linkText))
            {
                var link = Browser.TryFindElementBy(By.LinkText(linkText), true);
                link.Click();

                try
                {
					Browser.GetAlertWindow().Accept();
                }
                catch { }

                page = Context.POFactory.GetPageByUrl(new Uri(Browser.Url));
            }
            else
            {
                page = base.ClickLink(linkText, type, areaIdentifier);
            }

            return page;
        }

        public void NavigateToStudy(string studyName)
        {
            Context.CurrentPage = new ArchitectPage().NavigateToSelf();
            Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(studyName, () => new Project(studyName));
            Context.CurrentPage.As<ArchitectPage>().ClickProject(project.UniqueName);
            Context.CurrentPage.As<ArchitectLibraryPage>().NavigateTo("Publish Checks");
            Context.CurrentPage = this;
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
            string uniqueSourceCRFName = ((CrfVersion)SeedingContext.SeedableObjects[currentCrfName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_ddlCurrentVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueSourceCRFName);
        }

        public void SelectReferenceCRF(string referenceCrfName)
        {
            string uniqueTargetCRFName = ((CrfVersion)SeedingContext.SeedableObjects[referenceCrfName]).UniqueName;
            Dropdown sourceDropdown = Browser.FindElementById("_ctl0_Content_ddlReferenceVersionId").EnhanceAs<Dropdown>();
            sourceDropdown.SelectByPartialText(uniqueTargetCRFName);
        }
    }
}
