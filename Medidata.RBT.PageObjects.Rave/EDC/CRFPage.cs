using System;
using System.Collections.Generic;
using System.Linq;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CRFPage : BaseEDCPage
    {
        public CRFPage SelectUnitsForFields(IEnumerable<LabRangeModel> units)
        {
            foreach (var unit in units)
                FindField(unit.Field, "Unit").EnterData(unit.Unit, EnumHelper.GetEnumByDescription<ControlType>("dropdown"));

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
            var editButtons = Browser.TryFindElementsBy(
                By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"));
            if (editButtons == null || editButtons.Count == 0)
                throw new Exception(
                    "Last Log line cannot be opened becuase no log lines were found");

            editButtons[editButtons.Count - 1].Click();
            return this;
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
            return this;
        }

		public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
		{
            if (areaIdentifier.ToLower().Equals("form level"))
                ClickCheckBoxOnForm(identifier);
            else
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

                var contentR = Context.Browser.TryFindElementByPartialID("Content_R");
                var labDropdown = contentR.TryFindElementByPartialID("LOC_DropDown", false);
                bool isLabform = labDropdown != null;
                return isLabform;
            }
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

                IWebElement logTable = Context.Browser.TryFindElementById("log",false);
                IWebElement rowLeftSide = Context.Browser.TryFindElementBy(By.XPath("*//td[@class='crf_rowLeftSide']"));
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
                else if (IsMixedForm)
                    return new MixedDataPageControl(this).FindField(fieldName);
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
        public IEDCFieldControl FindLandscapeLogField(string fieldName, int rowIndex) 
        {
            return new LandscapeLogField(this, 
                fieldName, rowIndex);
        }
        public override IEDCFieldControl FindLandscapeLogField(string fieldName, int rowIndex, ControlType controlType = ControlType.Default)
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
            IWebElement currentElement = Context.Browser.TryFindElementBy(b =>
            {
                return Context.CurrentPage.GetFocusElement().FindElement(By.XPath(".[@id != '']"));
            });
            IWebElement element = this.GetElementByControlTypeAndValue(type, value);

            return currentElement.GetAttribute("ID") == element.GetAttribute("ID");
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
                return Browser.DropdownById("R_log_log_RP");

            if (identifier == "Reactivate")
                return Browser.DropdownById("R_log_log_IRP");

            if (identifier == "Clinical Significance")
                return Browser.DropdownById("dropdown");

            if (identifier == "Lab")
                return Browser.DropdownById("LOC_DropDown");

            return base.GetElementByName(identifier,areaIdentifier,listItem);
        }

        public override string URL { get { return "Modules/EDC/CRFPage.aspx"; } }
        public void SelectLabValue(string labName)
        {
            Dropdown dropDown = Browser.DropdownById("LOC_DropDown");
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

		public void CheckFormCount(string formName, int formCount)
		{
			var area = Browser.TryFindElementByPartialID("TblTaskItems");

			var formLinks = area.FindElements(By.XPath("./tbody/tr[position()>1]")).Where(x=>x.Text.Trim()==formName).ToList();

			Assert.AreEqual(formCount, formLinks.Count, string.Format("There are {0} forms ,expect {1}", formLinks.Count,formCount));
		}
    }
}
