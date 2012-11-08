using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class BlockPlansPageBase : RavePageBase
    {

        public IPage InactivatePlan()
        {
            IWebElement elem = Browser.TryFindElementByLinkText("Inactivate");
            if (elem != null)
            {
                elem.Click();
                TestContext.CurrentPage.As<PageBase>().GetAlertWindow().Accept();
            }
            return this;
        }

        public IPage ActivatePlan()
        {
            IWebElement elem = Browser.TryFindElementByLinkText("Activate");
            if (elem != null)
            {
                elem.Click();
                TestContext.CurrentPage.As<PageBase>().GetAlertWindow().Accept();
            }
            return this;
        }

        /// <summary>
        /// Create a new block plan for study based on plan name and entry role
        /// </summary>
        /// <param name="planName"></param>
        /// <param name="dataEntryRole"></param>
        public IPage CreateNewBlockPlan(string planName, string dataEntryRole)
        {

            //only do this if the block plan already doesn't exist
            IWebElement elem = Browser.TryFindElementByPartialID("AddNewBlockPlanLabel");
            if (elem != null && elem.Displayed)
            {
                this.ClickLink("New Block Plan");
                Textbox planNameTextbox = Browser.TryFindElementByPartialID("NewBlockPlanNameTextBox").EnhanceAs<Textbox>();
                planNameTextbox.Clear();
                planNameTextbox.SetText(planName);

                Role role = TestContext.GetExistingFeatureObjectOrMakeNew(dataEntryRole, () => new Role(dataEntryRole));
                if (role != null)
                {
	                ChooseFromDropdown("NewRoleDDL", role.UniqueName);
                }

                this.ClickLink("Save");
            }

            return this;
        }

        public IPage BlocksEdit(IEnumerable<TSDVObjectModel> blocks)
        {
            foreach (var block in blocks)
            {
                ModifyBlock(block.Name, block.SubjectCount);
            }
            return this;
        }

        public void ModifyBlock(string tierName, int subjectCount = -1)
        {
            Browser.TryFindElementByLinkText("Architect Defined").Parent().Parent().Images()[0].Click();
            Browser.FindElementsByPartialId("EditBlockNameTextBox")[0].EnhanceAs<Textbox>().SetText(tierName);
            Browser.FindElementsByPartialId("EditBlockSizeTextBox")[0].EnhanceAs<Textbox>().SetText(subjectCount.ToString());
            Browser.FindElementsByPartialId("EditBlockSizeTextBox")[0].Parent().Parent().Parent().Images()[2].Click();
        }

		/// <summary>
		/// To delete a tier passed by tier name
		/// Note: no need to pass content in parenthesis ex: if tier name is 
		/// "No Forms (Default Tier)" then only pass "No Forms" as tier name 
		/// </summary>
		/// <param name="tierName"></param>
		/// <returns></returns>
		public IPage DeleteTier(string tierName)
		{
			IWebElement elem = Browser.TryFindElementBySpanLinktext(GetFullTierName(tierName));
			if (elem != null)
			{
				IWebElement parentElem = elem.Parent().Parent();
				if (parentElem != null)
				{
					IWebElement delButton = parentElem.TryFindElementByPartialID("TierDeleteDiv");
					if (delButton != null)
					{
						delButton.Click();
						TestContext.CurrentPage.As<PageBase>().GetAlertWindow().Accept();
					}
				}
			}

			return this;
		}

		/// <summary>
		/// Pass the tier name and subject count to this method.
		/// It will apply the tier name if it exist in the dropdown list
		/// Also, it will apply the required subject count
		/// </summary>
		/// <param name="tierName"></param>
		/// <param name="subjectCount"></param>
		/// <returns></returns>
		public IPage ApplyTierWithSubjectCount(string tierName, string subjectCount)
		{
			IWebElement elem = Browser.TryFindElementByLinkText("Link Tier");
			if (elem != null)
			{
				elem.Click();
				IWebElement tierElement = Browser.TryFindElementByPartialID("TierToSelect");
				if (tierElement != null)
				{
					//dropdown to select the element by name of the tier
					var dropdowns = tierElement.FindElements(By.TagName("Select")).ToList();
					new SelectElement(dropdowns[0]).SelectByText(tierName);
					//enter the subject count in the textbox
					var countTxtBox = tierElement.TextboxById("LinkNewTierBlockSizeTextBox");
					countTxtBox.SetText(subjectCount);
					//save the user desired settings
					var saveBtn = tierElement.TryFindElementByPartialID("LinkNewTierSaveLabel");
					saveBtn.Click();
				}
			}
			return this;
		}

		#region helper methods
		private string GetFullTierName(string tierName)
		{
			switch (tierName)
			{
				case "No Forms":
					return "No Forms (Default Tier)";
				case "All Forms":
					return "All Forms (Default Tier)";
				case "Architect Defined":
					return "Architect Defined (Default Tier)";
				default:
					return tierName + " (Custom Tier)";
			}
		}
		#endregion
    }
}
