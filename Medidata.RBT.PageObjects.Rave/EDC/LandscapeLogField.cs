using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using System.Text.RegularExpressions;

namespace Medidata.RBT.PageObjects.Rave
{
    public class LandscapeLogField
        : ControlBase, IEDCLogFieldControl
    {
        #region CLASS DATA
        private readonly int m_columnId;
        private readonly int m_rowId;
        private readonly ControlType m_controlType;
        #endregion

        #region CONSTRUCTORS
        public LandscapeLogField(IPage page, string fieldName, int index)
            : base(page)
        {
            m_controlType = ControlType.Default;

            //Get ColumnID
            IWebElement topRowCell = this.Page.Browser.FindElement(By.XPath("//tr[@class='breaker']//td//*[contains(text(),'" + fieldName + "')]"));
            string topRowCellID = topRowCell.GetAttribute("id");
            m_columnId = Convert.ToInt32(topRowCellID.Substring(topRowCellID.LastIndexOf('_') + 2, topRowCellID.Length - (topRowCellID.LastIndexOf('_') + 2)));

            //Get RowID
            IWebElement tableCell = this.Page.Browser.FindElement(By.XPath("//td[contains(@id, 'Val_" + index + "_" + m_columnId + "')]"));
            string elementCellID = tableCell.GetAttribute("id");

            Match m = new Regex(@"^lVal_\d+_\d+_(?<ROW_ID>\d+)").Match(elementCellID);
            m_rowId = m.Success ? Convert.ToInt32(m.Groups["ROW_ID"].Value) : 0;
        }

        public LandscapeLogField(IPage page, string fieldName, int index, ControlType controlType)
            : base(page)
        {
            m_controlType = controlType;

            //Get ColumnID
            switch (controlType)
            {
                case ControlType.Default:
                case ControlType.Text:
                case ControlType.LongText:
                case ControlType.Datetime:
                case ControlType.RadioButton:
                case ControlType.RadioButtonVertical:
                case ControlType.DropDownList:
                    throw new NotImplementedException("Not implemented yet for :" + m_controlType);
                case ControlType.DynamicSearchList:
                    IWebElement topRowCell = this.Page.Browser.FindElement(By.XPath("//tr[@class='breaker']//td//*[contains(text(),'" + fieldName + "')]")).FindElement(By.XPath("../.."));
                    string topRowCellID = topRowCell.GetAttribute("id");
                    m_columnId = Convert.ToInt32(topRowCellID.Substring(topRowCellID.LastIndexOf('_') + 2, topRowCellID.Length - (topRowCellID.LastIndexOf('_') + 2)));
                    break;
                default:
                    throw new NotImplementedException("Unknown control type:" + m_controlType);
            }

            //Get RowID
            IWebElement tableCell = this.Page.Browser.FindElement(By.XPath("//td[contains(@id, 'Val_" + index + "_" + m_columnId + "')]"));
            string elementCellID = tableCell.GetAttribute("id");

            Match m = new Regex(@"^lVal_\d+_\d+_(?<ROW_ID>\d+)").Match(elementCellID);
            m_rowId = m.Success ? Convert.ToInt32(m.Groups["ROW_ID"].Value) : 0;
        }

        #endregion

        #region FUNCTIONS
        #region INTERFACE IEDCLogFieldControl
        public bool IsElementFocused(ControlType type, int position) 
        {
            var element = GetElementInColumnByRowIDColumnID(type, position);
            return this.Page.GetCurrentFocusedElement()
                .GetAttribute("ID") == element.GetAttribute("ID");
        }
        public void FocusElement(ControlType type, int position) 
        {
            var element = GetElementInColumnByRowIDColumnID(type, position);
            this.Page.FocusOnElementById(element.GetAttribute("ID"));
        }
        #endregion

        private IWebElement GetElementInColumnByRowIDColumnID(ControlType type, int position)
        {
            StringBuilder suffix = new StringBuilder(m_columnId + "_" + m_rowId);
            if (type == ControlType.RadioButton
                || type == ControlType.RadioButtonVertical
                || type == ControlType.ESigPage
                || type == ControlType.Datetime
                || type == ControlType.UnitDictionary)
                suffix.Append(ControlTypeInformation.GetSuffixByControlType(type, position));
            else
                suffix.Append(ControlTypeInformation.GetSuffixByControlType(type));
            return GetElementBySuffixColumn(type, suffix.ToString());
        }
        private static IWebElement GetElementBySuffixColumn(ControlType type, string suffix)
        {
            var attr = ControlType.RadioButton == type
                || ControlType.RadioButtonVertical == type
                   ? "id"
                   : "name";
            return TestContext.Browser.FindElement(By.XPath
                ("//*['"
                + suffix +
                "' = substring(@" + attr + ", string-length(@" + attr + ") - string-length('"
                + suffix +
                "') + 1)]"));
        }
        public void Click()
        {
            switch (m_controlType)
            {
                case ControlType.Default:
                case ControlType.Text:
                case ControlType.LongText:
                case ControlType.Datetime:
                case ControlType.RadioButton:
                case ControlType.RadioButtonVertical:
                case ControlType.DropDownList:
                    throw new NotImplementedException("Not implemented yet for :" + m_controlType);
                case ControlType.DynamicSearchList:
                    IWebElement tableCell = this.Page.Browser.FindElementById("_ctl0_Content_R_log_log_CF" + m_columnId.ToString() + "_" + m_rowId.ToString() + "_C_CRFSL");
                    tableCell.FindElement(By.ClassName("SearchList_DropButton")).Click();
                    break;
                default:
                    throw new NotImplementedException("Unknown control type:" + m_controlType);
            }
        }
        public bool IsDroppedDown()
        {
            switch (m_controlType)
            {
                case ControlType.Default:
                case ControlType.Text:
                case ControlType.LongText:
                case ControlType.Datetime:
                case ControlType.RadioButton:
                case ControlType.RadioButtonVertical:
                    throw new NotSupportedException("Not supported control type:" + m_controlType);
                case ControlType.DropDownList:
                    throw new NotImplementedException("Not implemented yet for :" + m_controlType);
                case ControlType.DynamicSearchList:
                    IWebElement tableCell = this.Page.Browser.FindElementById("_ctl0_Content_R_log_log_CF" + m_columnId.ToString() + "_" + m_rowId.ToString() + "_C_CRFSL_PickListBox");
                    return tableCell.Displayed;
                default:
                    throw new NotImplementedException("Unknown control type:" + m_controlType);
            }
        }

        #region INTERFACE IEDCFieldControl
        public AuditsPage ClickAudit() { throw new NotImplementedException(); }
		public void EnterData(string text, ControlType controlType) { throw new NotImplementedException(); }
        public bool HasDataEntered(string text) { throw new NotImplementedException(); }
        public OpenQA.Selenium.IWebElement FindQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void AnswerQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void CloseQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void CancelQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void Check(string checkName) { throw new NotImplementedException(); }
        public void Uncheck(string checkName) { throw new NotImplementedException(); }
        public string StatusIconPathLookup(string lookupIcon) { throw new NotImplementedException(); }
        #endregion
        #endregion
    }
}
