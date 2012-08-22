using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave
{
    public class PortraitLogField
        : ControlBase, IEDCLogFieldControl
    {
        #region CLASS DATA
        private readonly string m_fieldName;
        #endregion

        #region CONSTRUCTORS
        public PortraitLogField(IPage page, string fieldName)
            : base(page)
        {
            m_fieldName = fieldName;
        }
        #endregion


        #region FUNCTIONS
        #region INTERFACE IEDCLogFieldControl
        public bool IsElementFocused(ControlType type, int position) 
        {
            var element = GetElementInRowByLabel(type, position);
            return this.Page.GetCurrentFocusedElement()
                .GetAttribute("ID") == element.GetAttribute("ID");
        }
        public void FocusElement(ControlType type, int position) 
        {
            var element = GetElementInRowByLabel(type, position);
            this.Page.FocusOnElementById(element.GetAttribute("ID"));
        }
        #endregion



        private IWebElement GetElementInRowByLabel(ControlType type, int position)
        {
            string suffix;
            if (type == ControlType.RadioButton
                || type == ControlType.RadioButtonVertical
                || type == ControlType.ESigPage
                || type == ControlType.Datetime
                || type == ControlType.UnitDictionary)
                suffix = ControlTypeInformation.GetSuffixByControlType(type, position);
            else
                suffix = ControlTypeInformation.GetSuffixByControlType(type);
            return GetElementBySuffixRow(this.m_fieldName, suffix);
        }
        private static IWebElement GetElementBySuffixRow(string label, string suffix)
        {
            ReadOnlyCollection<IWebElement> leftSideTds = TestContext.Browser.FindElements(By.XPath("//td[@class='crf_rowLeftSide']"));
            IWebElement leftSideTd = leftSideTds.FirstOrDefault(x => x.Text.Split(new string[] { "\r\n" }, StringSplitOptions.None)[0] == label);

            if (leftSideTd == null)
                throw new Exception("Can't find field area:" + label);

            return leftSideTd.FindElement(By.XPath
                ("./../td[@class='crf_rowRightSide']//table[@class='crf_dataPointInternal']//*['"
                + suffix +
                "' = substring(@id, string-length(@id) - string-length('"
                + suffix +
                "') + 1)]"));
        }


        #region INTERFACE IEDCFieldControl
        public AuditsPage ClickAudit() { throw new NotImplementedException(); }
		public void EnterData(string text, ControlType controlType) { throw new NotImplementedException(); }
        public OpenQA.Selenium.IWebElement FindQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void AnswerQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void CloseQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public bool HasDataEntered(string text) { throw new NotImplementedException(); }
        public void CancelQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void Check(string checkName) { throw new NotImplementedException(); }
        public void Uncheck(string checkName) { throw new NotImplementedException(); }
        public string StatusIconPathLookup(string lookupIcon) { throw new NotImplementedException(); }
        #endregion
        #endregion
    }
}
