using System;
using System.Collections.Generic;
using System.Linq;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CRFPage : BaseEDCPage
    {
   

        public CRFPage SelectUnitsForFields(IEnumerable<LabRangeModel> units)
        {
            foreach (var unit in units)
                FindField(unit.Field, "Unit").EnterData(unit.Unit, EnumHelper.GetEnumByDescription<ControlType>("dropdownlist"));

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

        public CRFPage AddLogLine()
        {
            IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_R_log_log_AddLine");
            saveButton.Click();
            return this;
        }

        public CRFPage OpenLastLogline()
        {
            var editButtons = Browser.FindElements(
    By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"));
            editButtons[editButtons.Count - 1].Click();
            return this;
        }

        public CRFPage OpenLogline(int lineNum)
        {
            //TODO: this should not work in a non -log line form

            var editButtons = Browser.FindElements(
                By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"));
            editButtons[lineNum - 1].Click();
            return this;
        }

		public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
		{
			var field = this.FindField(areaIdentifier);
			if (isChecked)
			{
				field.Check(identifier);
			}
			else
				field.Uncheck(identifier);

			return this;
		}



        #region Query related
        public AuditsPage ClickAuditOnField(string fieldName)
        {
            return this.FindField(fieldName).ClickAudit();
        }

        public bool IsLabForm
        {
            get
            {
                if (URL.Equals("Modules/EDC/PrimaryRecordPage.aspx"))
                    return false;
                var contentR = TestContext.Browser.FindElementsByPartialId("Content_R")[0];
                var labDropdown = contentR.Dropdown("LOC_DropDown", true);
                bool isLabform = labDropdown != null;
                return isLabform;
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
            IWebElement el = TestContext.Browser.FindElements(By.XPath("//span[contains(@id,'Content_R')]")).FirstOrDefault();
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

		public override IEDCFieldControl FindField(string fieldName)
		{
			return FindField(fieldName, "Field");
		}

		/// <summary>
		/// TODO: what is Unit?
		/// </summary>
		/// <param name="fieldName"></param>
		/// <param name="attribute"></param>
		/// <returns></returns>
        public IEDCFieldControl FindField(string fieldName, string attribute = "Field")
        {
            if (attribute.Equals("Field"))
            {
                if (IsLabForm)
                    return new LabDataPageControl(this).FindField(fieldName);
                else
                    return new NonLabDataPageControl(this).FindField(fieldName);
            }
            else if (attribute.Equals("Unit"))
            {
                if (IsLabForm)
                    return new LabDataPageControl(this).FindUnitDropdown(fieldName);
            }
            else
                throw new NotImplementedException("FindField method in CRFPage.cs doesn't support attribute: " + attribute);

            return null;
        }

        /// <summary>
        /// Check that the field has the values in the order listed
        /// </summary>
        /// <param name="fieldName">The field to check for values order</param>
        /// <param name="values">The field values in the order they should be listed in</param>
        /// <returns>Returns true if the values are in the order passed in</returns>
        public bool FindFieldValuesInOrder(string fieldName, List<string> values)
        {
            IWebElement field = TestContext.Browser.WaitForElement(By.XPath("//a[text()='" + fieldName + "']"));
            IWebElement tbody = field.Parent().Parent().Parent();
            List<IWebElement> rows = tbody.FindElements(By.XPath("tr[@class='evenRow' or @class='oddRow']")).ToList();
            for (int i = 0; i < values.Count; i++)
            {
                if (rows[i].FindElement(By.XPath("td[position()=2]")).Text != values[i])
                    return false;
            }
            return true;
        }
        public IEDCFieldControl FindLandscapeLogField(string fieldName, int rowIndex) 
        {
            return new LandscapeLogField(this, 
                fieldName, rowIndex);
        }
        public IEDCFieldControl FindLandscapeLogField(string fieldName, int rowIndex, ControlType controlType = ControlType.Default)
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
                //case ControlType.DropDownList:
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
            var element = this.GetElementByControlTypeAndValue(type, value);
            return this.GetCurrentFocusedElement().GetAttribute("ID") == element.GetAttribute("ID");
        }


        public bool CanFindQuery(QuerySearchModel filter)
        {
            IWebElement queryContainer = null;
			//finding the field should not be put in try catch
			var field = FindField(filter.Field);
            try
            {
				queryContainer = field.FindQuery(filter);
            }
            catch
            {
            }
            return queryContainer != null;

        }


        public CRFPage AnswerQuery(string message, string fieldName, string answer)
        {
            FindField(fieldName).AnswerQuery(new QuerySearchModel { QueryMessage = message, Field = fieldName, Answer = answer });
            return this;
        }

        public CRFPage CloseQuery(string message, string fieldName)
        {
            FindField(fieldName).CloseQuery(new QuerySearchModel { QueryMessage = message, Field = fieldName });
            return this;
        }

        public CRFPage CancelQuery(string message, string fieldName)
        {
            FindField(fieldName).CancelQuery(new QuerySearchModel { QueryMessage = message, Field = fieldName });
            return this;
        }

        #endregion

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "Inactivate")
                return Browser.Dropdown("R_log_log_RP");

            if (identifier == "Reactivate")
                return Browser.Dropdown("R_log_log_IRP");

            if (identifier == "Clinical Significance")
                return Browser.Dropdown("dropdown");

            if (identifier == "Lab")
                return Browser.Dropdown("LOC_DropDown");

            return base.GetElementByName(identifier,areaIdentifier,listItem);
        }

        public override string URL { get { return "Modules/EDC/CRFPage.aspx"; } }
        public void SelectLabValue(string labName)
        {
            Dropdown dropDown = Browser.Dropdown("LOC_DropDown");
            dropDown.SelectByText(labName);
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
    }
}
