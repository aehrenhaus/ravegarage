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
    public class SubjectPage : BaseEDCPage, ICanVerifyInOrder, ITaskSummaryContainer, IVerifyDropdownState, IExpand
	{

		public SubjectPage ExpandTask(string header)
		{
			var TR = GetTaskSummaryArea(header);

			var expandButton = TR.Images().FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_right.gif"));
			expandButton.Click();
			
			//wait for contents to load
			Browser.TryFindElementByXPath("//body[@style='cursor: default;']",true);


			return this;
		}


		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
            IWebElement element;
            string id = "";

			if (identifier == "Reports")
			{
				var table = Browser.FindElementByXPath("//td[text()='Reports']/../../../tbody/tr[2]//table");
				return table;
			}

            if (identifier == "Save" || identifier == "LSave")
                id = "_ctl0_Content__ctl0_SBT_Save";
            else if (identifier == "Cancel" || identifier == "LCancel")
                id = "_ctl0_Content__ctl0_SBT_Cancel";
            else if (identifier == "Add Event" || identifier == "LAdd Event")
                id = "_ctl0_Content_SubjectAddEvent_MatrixList";
            else if (identifier == "Add" || identifier == "LAdd")
                id = "_ctl0_Content_SubjectAddEvent_SaveBtn";
            else if (identifier == "Enable" || identifier == "Disable" ||
                identifier == "LEnable" || identifier == "LDisable")
                id = "_ctl0_Content_SubjectAddEvent_LockAddEventSaveBtn";
            else if (identifier == "Set")
                id = "_ctl0_Content__ctl0_RadioButtons_0";
            else if (identifier == "Clear")
                id = "_ctl0_Content__ctl0_RadioButtons_1";
            else if (identifier == "Add Event is currently disabled for this subject." ||
                identifier == "LAdd Event is currently disabled for this subject.")
                id = "_ctl0_Content_SubjectAddEvent_DisableMatrixLabel";
            else if ((identifier == "Select 'Disabled' to not allow others to add events.")
                || (identifier == "Select 'Enabled' to allow others to add events."))
                id = "_ctl0_Content_SubjectAddEvent_NoEntryPermitHelpLabel";
            else
            {
                IWebElement result = Browser.TryFindElementBy(By.XPath("//input[@value='" + identifier + "']"));
                
                if(result == null)
                    result = base.GetElementByName(identifier, areaIdentifier, listItem);
                if (result != null)
                    return result;
                else
                    return GetTaskSummaryArea(identifier);
            }
            
            try
            {
                element = base.Browser.TryFindElementById(id);
            }
            catch
            {
                element = null;
            }

            return element;
		}

		public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
		{
            if (identifier == "Lock")
            {
                var chkBox = Browser.TryFindElementById("_ctl0_Content__ctl0_CB_Lock_0").EnhanceAs<Checkbox>();
                if (chkBox != null)
                    chkBox.Check();
                else
                    throw new NotFoundException(string.Format("Checkbox name {0} was not found", identifier));
            }

            return this;
		}

		public override string GetInfomation(string identifier)
		{
			if (identifier == "crfversion")
				return GetCRFVersion();
			return base.GetInfomation(identifier);
		}

        public override IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null, bool partial = false)
        {
            if (!string.IsNullOrEmpty(areaIdentifier) && string.Equals(areaIdentifier, "Grid View", StringComparison.InvariantCultureIgnoreCase))
            {
                IWebElement elem = Browser.TryFindElementById("Table1");
                if (elem != null)
                {
                    IWebElement link = elem.TryFindElementBy(By.XPath(".//a[text()='" + linkText + "'] | .//span[text()='" + linkText + "']"));
                    link.Click();

                    return this.WaitForPageLoads();
                }
                    
            }

            return base.ClickLink(linkText, objectType, areaIdentifier, partial);
        }

		public string GetCRFVersion()
		{
			var trs = Browser.Table("Table1").Children()[0].Children();
			var tr = trs[trs.Count - 1];
			var text = tr.Text.Trim();
			//CRF Version 1410 - Page Generated: 17 Jul 2012 10:00:25 FLE Daylight Time
			string version = text.Substring(11, text.IndexOf("-") -12).Trim();
			return version;
		}

		public override string URL
		{
			get
			{
				return "Modules/EDC/SubjectPage.aspx";
			}
		}
        /// <summary>
        /// Generate a pdf report. Extract the downloaded pdf, and save its contents in ScenarioText to be used later.
        /// </summary>
        /// <returns></returns>
        public void GeneratePDFReport(WebTestContext webTestContext)
        {
            ClickLink("PDF Report");
            new PromptsPage().GenerateReport(webTestContext);
        }
        public IPage ClickPrimaryRecordLink()
        {
            IWebElement element = Browser.FindElementById("_ctl0_Content_PrimaryRecordLink");
            if (element != null)
                element.Click();

            return WaitForPageLoads();
        }

		#region ICanVerifyInOrder

		public bool VerifyTableRowsInOrder(string tableIdentifier, Table matchTable)
		{
			throw new NotImplementedException();
		}

		public bool VerifyTableColumnInAphabeticalOrder(string tableIdentifier, string columnName, bool asc)
		{
			throw new NotImplementedException();
		}

		public bool VerifyTableInAphabeticalOrder(string tableIdentifier, bool hasHeader, bool asc)
		{
			return DefaultPOInterfaceImplementation.VerifyTableInAphabeticalOrder_Default(this, tableIdentifier, hasHeader, asc);
		}

		public bool VerifyThingsInOrder(string identifier)
		{
			throw new NotImplementedException();
		}

		#endregion

        #region ITaskSummaryContainer

        public TaskSummary GetTaskSummary() { return new TaskSummary(this); }
        
        #endregion

        #region IVerifyDropdownState
        public bool IsOptionSelected(string optionText, string dropdown)
        {
            throw new NotImplementedException();
        }

        public bool OptionExist(string optionText, string dropdown)
        {
            IWebElement dropdownElem = null;
            bool result = false;

            if (dropdown.Equals("Add Event", StringComparison.InvariantCultureIgnoreCase))
            {
                dropdownElem = Browser.TryFindElementById("_ctl0_Content_SubjectAddEvent_MatrixList");
            }

            if (dropdownElem != null)
                result = dropdownElem.EnhanceAs<Dropdown>().VerifyByText(optionText);
            else
                throw new NoSuchElementException(
                    string.Format("Specified dropdown [{0}] does not exist.", dropdown));

            return result;
        }
        #endregion

        public override bool VerifyObjectExistence(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, BaseEnhancedPDF pdf = null, bool? bold = null, bool shouldExist = true)
        {
            bool result = false;
            if (!string.IsNullOrEmpty(areaIdentifier) && areaIdentifier.Equals("Left Navigation List", StringComparison.InvariantCultureIgnoreCase))
            {
                IWebElement lefNavTable = Browser.TryFindElementById("_ctl0_LeftNav_EDCTaskList_TblTaskItems");
                if (lefNavTable != null)
                {
                    if (type.Equals("text"))
                        return lefNavTable.TryFindElementBy(By.XPath(string.Format("//*[text()='{0}']", identifier))) != null;
                }
                else
                    throw new NoSuchElementException(string.Format("The specified area identifier [{0}] does not exist.", areaIdentifier));
            }
            else
                result = base.VerifyObjectExistence(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold, shouldExist);

            return result;
        }

        public void Expand(string objectToExpand, string areaIdentifier = null)
        {

            if (!string.IsNullOrEmpty(areaIdentifier))
            {
                if (areaIdentifier.Equals("Add Event", StringComparison.InvariantCultureIgnoreCase) &&
                    objectToExpand.Equals("dropdown", StringComparison.InvariantCultureIgnoreCase))
                {
                    IWebElement addEventDropdown = Browser.TryFindElementById("_ctl0_Content_SubjectAddEvent_MatrixList");
                    addEventDropdown.Click();
                }

            }
        }
    }
}
