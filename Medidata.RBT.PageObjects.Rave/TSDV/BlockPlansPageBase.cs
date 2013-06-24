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
using System.Threading;
using Medidata.RBT.StateVerificationInterfaces;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class BlockPlansPageBase : RavePageBase, IVerifyObjectExistence, IVerifyControlEnabledState
    {
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "edit block plan")
				return Browser.TryFindElementById("_ctl0_Content__ctl0_dgProjectBlockPlan__ctl2_ProjectBlockPlanEdit");

			if (identifier == "save block plan")
				return Browser.TryFindElementById("_ctl0_Content__ctl0_dgProjectBlockPlan__ctl2_ProjectBlockPlanEditSave");

			if (identifier == "Randomization Type")
				return Browser.TryFindElementById("_ctl0_Content__ctl0_dgProjectBlockPlan__ctl2_ddl_RandomizationType");

			return base.GetElementByName(identifier, areaIdentifier, listItem);
		}

        public IPage InactivatePlan()
        {
            IWebElement elem = Browser.TryFindElementByLinkText("Inactivate");
            if (elem != null)
            {
                elem.Click();
				Browser.GetAlertWindow().Accept();
            }
            return this;
        }

        public IPage ActivatePlan()
        {
            IWebElement elem = Browser.TryFindElementByLinkText("Activate");
            if (elem != null)
            {
                elem.Click();
				Thread.Sleep(1000);
				Browser.GetAlertWindow().Accept();
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

                Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(dataEntryRole, () => new Role(dataEntryRole));
                if (role != null)
                {
					ChooseFromDropdown("_ctl0_Content__ctl0_NewRoleDDL", role.UniqueName);
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

        public IPage AddBlocks(IEnumerable<TSDVBlockModel> blocks)
        {
            foreach (var block in blocks)
            {
                this.ClickLink("New Block");
                AddBlock(block.Name, block.SubjectCount, block.Repeated);

                Browser.TryFindElementByPartialID("_Content_BlockPlanDetailCtrl_SaveNewDiv").Click();
         
            }
            Browser.TryFindElementByPartialID("_BlockPlanDetailCtrl_AddNewBlockLabel");
            return this;
        }

        private void LinkByID(string p)
        {
            throw new NotImplementedException();
        }

        public void AddBlock(string blockName, int subjectCount, bool repeated)
        {
            var textBoxes = Browser.Textboxes();
            textBoxes.FirstOrDefault(b => b.Id.Contains("BlockPlanDetailCtrl_NewBlockName")).EnhanceAs<Textbox>().SetText(blockName);;
            textBoxes.FirstOrDefault(b => b.Id.Contains("BlockPlanDetailCtrl_NewBlockSize")).EnhanceAs<Textbox>().SetText(subjectCount.ToString());
            if (repeated) Browser.TryFindElementByPartialID("_BlockPlanDetailCtrl_NewBlockIsRepeatedCheckbox").EnhanceAs<Checkbox>().Check();
        }

        public void ModifyBlock(string blockName, int subjectCount = -1)
        {
			var container = Browser.TryFindElementByLinkText("Architect Defined").Parent().Parent();
			container.Images()[0].Click();
            Browser.TryFindElementByPartialID("EditBlockNameTextBox").EnhanceAs<Textbox>().SetText(blockName);
			Browser.TryFindElementByPartialID("EditBlockSizeTextBox").EnhanceAs<Textbox>().SetText(subjectCount.ToString());
			Browser.TryFindElementByPartialID("EditBlockSizeTextBox").Parent().Parent().Parent().Images()[2].Click();
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
						Browser.GetAlertWindow().Accept();
                        //To acknowlege deletion
                        try
                        {
                            IAlert alertWin = Browser.GetAlertWindow();
                            if (alertWin != null)
                                alertWin.Accept();
                        }
                        catch { }
					}
				}
			}

			return this;
		}


        /// <summary>
        /// Applies the tier with subject count.
        /// </summary>
        /// <param name="tierName">Name of the tier.</param>
        /// <param name="subjectCount">The subject count.</param>
        /// <param name="areaIndentifier">The area indentifier.</param>
        /// <returns></returns>
        public IPage ApplyTierWithSubjectCount(string tierName, string subjectCount, string areaIndentifier = null)
		{
            IWebElement elem = null;
            IWebElement context = null;
            if (!string.IsNullOrEmpty(areaIndentifier))
            {
                context = Browser.TryFindElementByLinkText(areaIndentifier).Parent().Parent();
                elem = context.TryFindElementBySpanLinktext("Link Tier");
            }
                       
			if(elem == null)
            {
                elem = Browser.TryFindElementByLinkText("Link Tier");
            }
            
            if (elem != null)
			{
				elem.Click();
                IWebElement tierElement = context == null ? Browser.TryFindElementByPartialID("TierToSelect") : context.TryFindElementByPartialID("TierToSelect");
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

        public IPage UpdateTierWithSubjectCount(string tierName, string subjectCount, string areaIndentifier = null)
        {
            IWebElement elem = null;
            IWebElement context = null;
            if (!string.IsNullOrEmpty(areaIndentifier))
            {
                context = Browser.TryFindElementByLinkText(areaIndentifier).Parent().Parent();
                elem = context.TryFindElementByPartialID("__ctl0_TierEdit");
            }

            if (elem == null)
            {
                elem = Browser.TryFindElementByLinkText("__ctl0_TierEdit");
            }

            if (elem != null)
            {
                elem.Click();
                context.TryFindElementByPartialID("__ctl0_EditTierSizeTextBox").EnhanceAs<Textbox>().SetText(subjectCount.ToString());
                var saveBtn = context.TryFindElementByPartialID("__ctl0_TierEditEndSaveDiv");
                saveBtn.Click();                
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


		#region VerifyExist

        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            string identifier,
            bool exactMatch,
            int? amountOfTimes,
            RBT.BaseEnhancedPDF pdf,
            bool? bold,
            bool shouldExist = true)
		{
			var area = Browser.TryFindElementById("_ctl0_Content__ctl0_dgProjectBlockPlan");
            return !exactMatch && area.Text.Contains(identifier);
		}

        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            List<string> identifiers,
            bool exactMatch,
            int? amountOfTimes,
            RBT.BaseEnhancedPDF pdf,
            bool? bold,
            bool shouldExist = true)
        {
            foreach (string identifier in identifiers)
                if (VerifyObjectExistence(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }

		#endregion

        public bool VerifyControlEnabledState(string identifier, bool isEnabled, string areaIdentifier)
		{
            if (identifier == "Randomization Type")
			{
				var ele = Browser.TryFindElementById("_ctl0_Content__ctl0_dgProjectBlockPlan__ctl2_ddl_RandomizationType");
                if(isEnabled)
				    return ele.EnhanceAs<EnhancedElement>().Enabled;
                else
                    return ele.EnhanceAs<EnhancedElement>().Disabled;
			}
			throw new NotImplementedException();
		}
	}
}
