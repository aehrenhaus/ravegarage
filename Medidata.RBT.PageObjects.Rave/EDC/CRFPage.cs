using System;
using System.Collections.Generic;
using System.Linq;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.PageObjects.Rave.TableModels;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CRFPage : BaseEDCPage, IVerifyObjectExistence
    {
        public CRFPage SelectUnitsForFields(IEnumerable<LabRangeModel> units)
        {
            foreach (var unit in units)
                FindUnit(unit.Field).EnterData(unit.Unit, EnumHelper.GetEnumByDescription<ControlType>("dropdown"));

            return this;
        }

        public bool FindFieldData(IEnumerable<FieldModel> fields)
        {
            foreach (var field in fields)
            {
                if (!FindField(field.Field).HasDataEntered(field.Data))
                    return false;
            }
            return true;    
        }

        public void ClearDSL(string dslfieldname)
        {
            var controlType = ControlType.DynamicSearchList;
            IEDCFieldControl fieldControl = FindField(dslfieldname);
            //since the control behaves differently in selenium, need to enter a single key first, then blank for normal behavior
            fieldControl.EnterData("a", controlType);
            fieldControl.EnterData(String.Empty, controlType);
        }

        public CRFPage AddLogLine()
        {
            IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_R_log_log_AddLine");
            saveButton.Click();
            return this;
        }

        public CRFPage OpenLastLogline()
        {
            var editButtons = Browser.TryFindElementsBy(
                By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"));
            if (editButtons == null || editButtons.Count == 0)
                throw new Exception(
                    "Last Log line cannot be opened becuase no log lines were found");

            editButtons[editButtons.Count - 1].Click();
            return this.WaitForPageLoads() as CRFPage;
        }

        public CRFPage OpenLogline(int lineNum)
        {
            //TODO: this should not work in a non -log line form

            var editButtons = Browser.TryFindElementsBy(
                By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"), 
                isWait: true);
            if (editButtons == null || editButtons.Count == 0)
                throw new Exception(
                    string.Format(
                        "Log line [{0}] cannot be opened becuase no log lines were found", 
                        lineNum));

            editButtons[lineNum - 1].Click();
            return this.WaitForPageLoads() as CRFPage;
        }

		public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
		{
            bool specificControl = false;
            if (identifier != null && identifier.Equals("Confirm"))
            {
                Browser.TryFindElementByPartialID("INA_INACB").EnhanceAs<Checkbox>().Check();
                specificControl = true;
            }
            if (areaIdentifier != null && areaIdentifier.ToLower().Equals("form level"))
            {
                ClickCheckBoxOnForm(identifier);
                specificControl = true;
            }
            if(!specificControl)
            {
                var field = this.FindField(areaIdentifier);
                if (isChecked)
                {
                    field.Check(identifier);
                }
                else
                    field.Uncheck(identifier);
            }

			return this;
		}

        public new bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            string identifier,
            bool exactMatch = false,
            int? amountOfTimes = null,
            RBT.BaseEnhancedPDF pdf = null,
            bool? bold = null,
            bool shouldExist = true)
        {
            if(identifier.Equals("Save", StringComparison.InvariantCultureIgnoreCase) && type.Equals("control", StringComparison.InvariantCultureIgnoreCase))
                return base.VerifyObjectExistence(areaIdentifier, type, "_ctl0_Content_R_footer_SB", exactMatch, amountOfTimes, pdf, bold);

            return base.VerifyObjectExistence(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold);
        }

        #region Query related
        public AuditsPage ClickAuditOnField(string fieldName)
        {
            return this.FindField(fieldName).ClickAudit();
        }

        /// <summary>
        /// If this form a mixed form, returns true, otherwise returns false.
        /// </summary>
        public bool IsMixedForm
        {
            get
            {
                if (URL.Equals("Modules/EDC/PrimaryRecordPage.aspx"))
                    return false;

                IWebElement logTable = Context.Browser.TryFindElementById("log", false);
                IWebElement rowLeftSide = Context.Browser.TryFindElementBy(By.XPath("*//td[@class='crf_rowLeftSide']"), false);
                if (logTable != null && rowLeftSide != null)
                    return true;
                return false;
            }
        }

		/// <summary>
		/// TODO: please refactor this method. Make it a method on IEDCField, not on CRFPage
		/// </summary>
		/// <param name="clinSignificance"></param>
		/// <param name="fieldText"></param>
		/// <returns></returns>
        public bool FieldWithClinSignificanceExists(string clinSignificance, string fieldText)
        {
            IWebElement el = Context.Browser.FindElements(By.XPath("//span[contains(@id,'Content_R')]")).FirstOrDefault();
            if (el.Tables().Count <= 5)
                return false;

            for (int i = 1; i< el.Tables()[5].Rows().Count; i++)
            {
                var row = el.Tables()[5].Rows()[i];
                if (row.Text.IndexOf(fieldText + "\r\n") == 0 && (i+1) < el.Tables()[5].Rows().Count)
                {
                    var nextRow = el.Tables()[5].Rows()[i + 1];
                    if (nextRow.Text.IndexOf("Clinical Significance: " + clinSignificance) == 0)
                        return true;
                }
            }
            return false;
        }

		/// <summary>
		/// TODO: what is Unit?
		/// </summary>
		/// <param name="fieldName"></param>
		/// <param name="attribute"></param>
        /// <param name="record">The record position (ie. log line number)</param>
		/// <returns></returns>
        public IEDCFieldControl FindUnit(string fieldName, int? record = null)
        {
            return new LabDataPageControl(this).FindUnitDropdown(fieldName);
        }

        /// <summary>
        /// Return a form header control which has controls for the header part of the form
        /// </summary>
        /// <returns>A form header control which has controls for the header part of the form</returns>
        public FormHeaderControl FindHeader()
        {
            return new FormHeaderControl(new CRFPage());
        }

        /// <summary>
        /// Check that the field has the values in the order listed
        /// </summary>
        /// <param name="fieldName">The field to check for values order</param>
        /// <param name="values">The field values in the order they should be listed in</param>
        /// <returns>Returns true if the values are in the order passed in</returns>
        public bool FindFieldValuesInOrder(string fieldName, List<string> values)
        {
            IWebElement field = Context.Browser.TryFindElementByXPath("//a[text()='" + fieldName + "']");
            IWebElement tbody = field.Parent().Parent().Parent();
            List<IWebElement> rows = tbody.FindElements(By.XPath("tr[@class='evenRow' or @class='oddRow']")).ToList();
            for (int i = 0; i < values.Count; i++)
            {
                if (rows[i].FindElement(By.XPath("td[position()=2]")).Text != values[i])
                    return false;
            }
            return true;
        }

        /// <summary>
        /// Click audit on a record in a log form
        /// </summary>
        /// <param name="recordPosition">1 indexed record position, should be passed down directly from the step</param>
        /// <returns>The current page</returns>
        public IPage ClickAuditOnRecord(int recordPosition)
        {
            List<IWebElement> rows = Browser.FindElements(By.XPath("//tr[@class='evenRow' or @class='oddRow']")).OrderBy(x => x.Location.Y).ToList();
            IWebElement row = rows[recordPosition - 1]; //Change it to be zero indexed
            IWebElement element = row.TryFindElementByPartialID("DataStatusHyperlink");
            if (element == null)
                throw new Exception(String.Format("Record at position \"{0}\" does not exist", recordPosition));

            element.Click();

            return WaitForPageLoads();
        }

        /// <summary>
        /// Find a landscape log field by record number
        /// </summary>
        /// <param name="recordNumber">Number of the record</param>
        /// <returns>The LandscapeLogField corresponding to the passed in record number</returns>
        public IEDCFieldControl FindLandscapeLogField(int recordNumber)
        {
            return new LandscapeLogField(this, recordNumber);
        }

        public IEDCFieldControl FindLandscapeLogField(string fieldName, int rowIndex)
        {
            return new LandscapeLogField(this,
                fieldName, rowIndex);
        }
        public LandscapeLogField FindLandscapeLogField(string fieldName, int rowIndex, ControlType controlType = ControlType.Default)
        {
            switch (controlType)
            {
                case ControlType.Default:
                    return new LandscapeLogField(this, fieldName, rowIndex);
                //case ControlType.Text:
                //case ControlType.LongText:
                //case ControlType.Datetime:
                //case ControlType.RadioButton:
                //case ControlType.RadioButtonVertical:
                case ControlType.DropDown:
                case ControlType.DynamicSearchList:
                    return new LandscapeLogField(this, fieldName, rowIndex, controlType);
                default:
                    throw new Exception("Not supported control type:" + controlType);
            }
        }
        public IEDCFieldControl FindPortraitLogField(string fieldName)
        {
            return new PortraitLogField(this,
                fieldName);
        }

        public bool IsElementFocused(ControlType type, string value)
        {
            IWebElement currentElement = Context.Browser.TryFindElementBy(b =>
            {
                return Context.CurrentPage.GetFocusElement().FindElement(By.XPath(".[@id != '']"));
            });
            IWebElement element = this.GetElementByControlTypeAndValue(type, value);

            return currentElement.GetAttribute("ID") == element.GetAttribute("ID");
        }

        public bool CanFindMarking(ResponseSearchModel filter, MarkingType responseType)
        {
            IWebElement queryContainer = null;
            IEDCFieldControl field = FindField(filter.Field);
            queryContainer = field.FindResponse(filter, responseType);

            return queryContainer != null;
        }

        public CRFPage AnswerQuery(string message, string fieldName, string answer)
        {
            FindField(fieldName).AnswerQuery(new QuerySearchModel { Message = message, Field = fieldName, Answer = answer });
            return this;
        }

        public CRFPage CloseQuery(string message, string fieldName)
        {
            FindField(fieldName).CloseQuery(new QuerySearchModel { Message = message, Field = fieldName });
            return this;
        }

        public CRFPage CancelQuery(string message, string fieldName)
        {
            FindField(fieldName).CancelQuery(new QuerySearchModel { Message = message, Field = fieldName });
            return this;
        }

        #endregion

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "Save" || identifier == "LSave")
                return base.Browser.TryFindElementById("_ctl0_Content_R_footer_SB");
            else if (identifier == "Cancel" || identifier == "LCancel")
                return base.Browser.TryFindElementById("_ctl0_Content_R_footer_CB");
            else if (identifier == "Add a new Log line" || identifier == "LAdd a new Log line") 
                return base.Browser.TryFindElementById("_ctl0_Content_R_log_log_AddLine");
            else if (identifier == "Modify Templates" || identifier == "LModify Templates")
                return base.Browser.TryFindElementById("_ctl0_Content_R_header_TEM_EditLink");
            else if (identifier == "Marking" || identifier == "LMarking")
                return base.Browser.TryFindElementByPartialID("MarkingButton");
            else if (identifier == "Inactivate")
                return Browser.DropdownById("R_log_log_RP");
            else if (identifier == "Inactivate Link")
                return base.Browser.TryFindElementById("_ctl0_Content_R_log_log_Inactivate");
            else if (identifier == "Reactivate")
                return Browser.DropdownById("R_log_log_IRP");
            else if (identifier == "Reactivate Link")
                return base.Browser.TryFindElementById("_ctl0_Content_R_log_log_Activate");
            else if (identifier == "Clinical Significance")
                return Browser.DropdownById("dropdown");
            else if (identifier == "Lab")
                return Browser.DropdownById("LOC_DropDown");

            return base.GetElementByName(identifier,areaIdentifier,listItem);
        }

        public override string URL { get { return "Modules/EDC/CRFPage.aspx"; } }
        public void SelectLabValue(string labName)
        {
            Dropdown dropDown = Browser.DropdownById("LOC_DropDown");
            dropDown.SelectByText(labName);
            WaitForPageLoads();
        }


        public bool VerifyLabDataPoints(IEnumerable<LabRangeModel> fields)
        {
            foreach (var field in fields)
            {
                LabFieldControl fieldObj = FindField(field.Field) as LabFieldControl;
                if (fieldObj==null || !fieldObj.VerifyData(field)) return false;
            }
            return true;
        }

		public void CheckFormCount(string formName, int formCount)
		{
			var area = Browser.TryFindElementByPartialID("TblTaskItems");

			var formLinks = area.FindElements(By.XPath("./tbody/tr[position()>1]")).Where(x=>x.Text.Trim()==formName).ToList();

			Assert.AreEqual(formCount, formLinks.Count, string.Format("There are {0} forms ,expect {1}", formLinks.Count,formCount));
		}

        /// <summary>
        /// Place markings against fields on the page
        /// </summary>
        /// <param name="markings">The markings to place</param>
        /// <param name="markingType">The type of markings to place</param>
        public void PlaceMarkings(List<MarkingModel> markings, MarkingType markingType)
        {
            foreach (MarkingModel marking in markings)
                PlaceMarking(marking, markingType);
        }

        /// <summary>
        /// Place a sticky against a field on the page
        /// </summary>
        /// <param name="fieldName">The name of the field to place the sticky against</param>
        /// <param name="responder">Who should respond to the sticky</param>
        /// <param name="text">The text of the sticky</param>
        public void PlaceMarking(MarkingModel marking, MarkingType markingType)
        {
            IEDCFieldControl fieldControl = FindField(marking.Field, record: marking.Record);
            fieldControl.PlaceMarking(marking.Responder, marking.Text, markingType, marking.Class, marking.Code);
        }

        /// <summary>
        /// Verifies the deviation.
        /// </summary>
        /// <param name="pdComponent">Protocol Deviation component (class/code)</param>
        /// <param name="value">Value of the Protocol Deviation component (class/code value)</param>
        /// <param name="exists">if set to <c>true</c> [exists]</param>
        /// <returns></returns>
        public bool VerifyDeviation(string pdComponent, string value, bool exists)
        {
            bool isExists = true;

            var elSelects = Browser.TryFindElementBy(By.XPath("//*[contains(text(),'Protocol Deviation')]/../..")).TryFindElementsBy(By.XPath(".//select"));
            int i = elSelects.Count;
            var dropdownCode = elSelects[i - 2].EnhanceAs<Dropdown>();
            var dropdownClass = elSelects[i - 1].EnhanceAs<Dropdown>();

            var dropdown = String.Compare(pdComponent, "class", StringComparison.CurrentCultureIgnoreCase) == 0 ? dropdownClass : dropdownCode;

            if (exists)
            {
                isExists = dropdown.VerifyByText(value) == true;
            }
            else
            {
                isExists = dropdown.VerifyByText(value) == false;
            }

            return isExists;
        }
    }
}
