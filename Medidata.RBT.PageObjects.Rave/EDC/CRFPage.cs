using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using System.Text.RegularExpressions;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CRFPage : BaseEDCTreePage
    {
        public CRFPage FillDataPoints(IEnumerable<FieldModel> fields)
        {
            foreach (var field in fields)
				FindField(field.Field).EnterData(field.Data, EnumHelper.GetEnumByDescription < ControlType>(field.ControlType));

            return this;
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

        public CRFPage ClickModify()
        {
            IWebElement editButton = Browser.WaitForElement("header_SG_PencilButton");
            if (editButton == null)
                throw new Exception("Can not find the modify button");
            editButton.Click();
            return this;
        }

        public CRFPage CancelForm()
        {
            IWebElement btn = Browser.WaitForElement("Content_R_footer_CB");
            if (btn == null)
                throw new Exception("Can not find the Cancel button");
            btn.Click();
            return this;
        }

        public CRFPage SaveForm()
        {
            IWebElement btn = Browser.WaitForElement("Content_R_footer_SB");
            if (btn == null)
                throw new Exception("Can not find the Save button");
            btn.Click();
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
                var contentR = TestContext.Browser.FindElementsByPartialId("Content_R")[0];
                var labDropdown = contentR.Dropdown("LOC_DropDown", true);
                bool isLabform = labDropdown != null;
                return isLabform;
            }
        }

        public IEDCFieldControl FindField(string fieldName)
        {
            if (IsLabForm)
                return new LabDataPageControl(this).FindField(fieldName);
            else
                return new NonLabDataPageControl(this).FindField(fieldName);
        }
        public IEDCLogFieldControl FindLandscapeLogField(string fieldName, int rowIndex) 
        {
            return new LandscapeLogField(this, 
                fieldName, rowIndex);
        }
        public IEDCLogFieldControl FindPortraitLogField(string fieldName)
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

        protected override IWebElement GetElementByName(string name)
        {
            if (name == "Inactivate")
                return Browser.Dropdown("R_log_log_RP");

            if (name == "Reactivate")
                return Browser.Dropdown("R_log_log_IRP");

            return base.GetElementByName(name);
        }

        public override string URL { get { return "Modules/EDC/CRFPage.aspx"; } }
    }
}
