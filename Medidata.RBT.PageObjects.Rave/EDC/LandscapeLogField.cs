using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using System.Text.RegularExpressions;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
    public class LandscapeLogField
        : BaseEDCFieldControl
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
            IWebElement topRowCell = this.Page.Browser.TryFindElementBy(
                By.XPath("//tr[@class='breaker']//td//*[contains(text(),'" + fieldName + "')]"));
            if (topRowCell == null)
                throw new Exception(
                    string.Format("Cannot find top row cell for fieldName [{0}]", fieldName));

            string topRowCellID = topRowCell.GetAttribute("id");
            m_columnId = Convert.ToInt32(topRowCellID.Substring(topRowCellID.LastIndexOf('_') + 2, topRowCellID.Length - (topRowCellID.LastIndexOf('_') + 2)));

            //Get RowID
            IWebElement tableCell = this.Page.Browser.TryFindElementBy(
                By.XPath("//td[contains(@id, 'Val_" + index + "_" + m_columnId + "')]"));
            if(tableCell == null)
                throw new Exception(
                    string.Format("Cannot find table cell for fieldName [{0}]", fieldName));

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
                    IWebElement topRowCell = this.Page.Browser.TryFindElementBy(
                        By.XPath("//tr[@class='breaker']//td//*[contains(text(),'" + fieldName + "')]../.."));
                    if (topRowCell == null)
                        throw new Exception(
                            string.Format("Cannot find top row cell for fieldName [{0}]", fieldName));

                    //IWebElement topRowCell = this.Page.Browser.FindElement(By.XPath("//tr[@class='breaker']//td//*[contains(text(),'" + fieldName + "')]")).FindElement(By.XPath("../.."));
                    string topRowCellID = topRowCell.GetAttribute("id");
                    m_columnId = Convert.ToInt32(topRowCellID.Substring(topRowCellID.LastIndexOf('_') + 2, topRowCellID.Length - (topRowCellID.LastIndexOf('_') + 2)));
                    break;
                default:
                    throw new NotImplementedException("Unknown control type:" + m_controlType);
            }

            string xPath = String.Empty;
            string regPattern = String.Empty;
            if (this.Page is DDEPage)
            {
                regPattern = @"^lVal_\d+_(?<ROW_ID>\d+)_F-_S-";
                xPath = "//td[contains(@id, 'lVal" + "_" + m_columnId + "')]";
            }
            else if (this.Page is CRFPage)
            {
                regPattern = @"^lVal_\d+_\d+_(?<ROW_ID>\d+)";
                xPath =  "//td[contains(@id, 'Val_" + index + "_" + m_columnId + "')]";
            }

            //Get RowID
            IWebElement tableCell = this.Page.Browser.FindElement(By.XPath(xPath));
            string elementCellID = tableCell.GetAttribute("id");

            Match m = new Regex(regPattern).Match(elementCellID);
            m_rowId = m.Success ? Convert.ToInt32(m.Groups["ROW_ID"].Value) : 0;
        }

        #endregion

        #region FUNCTIONS
        #region INTERFACE IEDCLogFieldControl
		public override bool IsElementFocused(ControlType type, int position) 
        {
            var element = GetElementInColumnByRowIDColumnID(type, position);
            var actualId = this.Page.GetFocusElement().GetAttribute("ID");
            var expectedId = element.GetAttribute("ID");
            Console.WriteLine(string.Format(
                "-> LandscapeLogField.IsElementFocused : Actual [{0}], Expected [{1}]",
                actualId,
                expectedId));
            return actualId == expectedId;
        }
		public override void FocusElement(ControlType type, int position) 
        {
            var element = GetElementInColumnByRowIDColumnID(type, position);
            this.Page.SetFocusElement(element);
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
            var result = TestContext.Browser.TryFindElementBy(By.XPath
                ("//*['"
                + suffix +
                "' = substring(@" + attr + ", string-length(@" + attr + ") - string-length('"
                + suffix +
                "') + 1)]"));

            return result;
        }
        public override void Click()
        {
            string prefix = String.Empty;
            if (this.Page is DDEPage)
            {
                prefix = "dde1";
            }
            else if (this.Page is CRFPage)
            {
                prefix = "R";
            }

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
                    string contolId = String.Format("_ctl0_Content_{0}_log_log_CF{1}_{2}_C_CRFSL", prefix, m_columnId.ToString(), m_rowId.ToString()); 
                    IWebElement tableCell = this.Page.Browser.FindElementById(contolId);
                    tableCell.FindElement(By.ClassName("SearchList_DropButton")).Click();
                    break;
                default:
                    throw new NotImplementedException("Unknown control type:" + m_controlType);
            }
        }
		public override bool IsDroppedDown()
        {
            string prefix = String.Empty;
            if (this.Page is DDEPage)
            {
                prefix = "dde1";
            }
            else if (this.Page is CRFPage)
            {
                prefix = "R";
            }

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
                    //_ctl0_Content_dde1_log_log_CF67041_27853_C_CRFSL_PickListBox
                    string contolId = String.Format("_ctl0_Content_{0}_log_log_CF{1}_{2}_C_CRFSL", prefix, m_columnId.ToString(), m_rowId.ToString()); 
                    IWebElement tableCell = this.Page.Browser.FindElementById(contolId);
                    return tableCell.Displayed;
                default:
                    throw new NotImplementedException("Unknown control type:" + m_controlType);
            }
        }
        #endregion

        #region INTERFACE IEDCFieldControl
        public AuditsPage ClickAudit() { throw new NotImplementedException(); }
	
        public override void EnterData(string text, ControlType controlType, string additionalData = "") {
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
                    IWebElement tableCell = this.Page.Browser.FindElementById("_ctl0_Content_R_log_log_CF" + m_columnId.ToString() + "_" + m_rowId.ToString() + "_C_CRFSL");                 
                    tableCell.Textboxes()[0].SetText(text);
			     //   tableCell.FindElement(By.ClassName("SearchList_DropButton")).Click();
                    break;
                default:
                    throw new NotImplementedException("Unknown control type:" + m_controlType);
            }
        
        }
        public bool HasDataEntered(string text) { throw new NotImplementedException(); }
        public OpenQA.Selenium.IWebElement FindQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void AnswerQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void CloseQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void CancelQuery(QuerySearchModel filter) { throw new NotImplementedException(); }
        public void Check(string checkName) { throw new NotImplementedException(); }
        public void Uncheck(string checkName) { throw new NotImplementedException(); }
        public string StatusIconPathLookup(string lookupIcon) { throw new NotImplementedException(); }
        #endregion


	}
}
