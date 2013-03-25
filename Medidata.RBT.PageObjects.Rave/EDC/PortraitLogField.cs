using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
    public class PortraitLogField
		: BaseEDCFieldControl
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
        public override bool IsElementFocused(ControlType type, int position) 
        {
            IWebElement currentElement = Page.Browser.TryFindElementBy(b =>
                {
					return Page.GetFocusElement().FindElement(By.XPath(".[@id != '']"));
                }, true, 30);
            IWebElement element = GetElementInRowByLabel(type, position);

            return currentElement.GetAttribute("ID") == element.GetAttribute("ID");
        }

		public override void FocusElement(ControlType type, int position) 
        {
            var element = GetElementInRowByLabel(type, position);
            this.Page.SetFocusElement(element);
        }
        #endregion

        private IWebElement GetElementInRowByLabel(ControlType type, int position)
        {
            string suffix, altSuffix = null;
            if (type == ControlType.RadioButton
                || type == ControlType.RadioButtonVertical
                || type == ControlType.ESigPage
                || type == ControlType.Datetime
                || type == ControlType.UnitDictionary)
                suffix = ControlTypeInformation.GetSuffixByControlType(type, position);
            else
                suffix = ControlTypeInformation.GetSuffixByControlType(type);

            //In the case where ESigPage is missing the username textbox - ESigPage just converges into Text
            if (type == ControlType.ESigPage)
                altSuffix = ControlTypeInformation.GetSuffixByControlType(ControlType.Text);
            
            return GetElementBySuffixRow(this.m_fieldName, suffix, altSuffix);
        }
        private IWebElement GetElementBySuffixRow(string label, params string[] suffixParams)
        {
            //Filter out any null suffixes
            suffixParams = suffixParams
                .Where(item => !string.IsNullOrEmpty(item))
                .ToArray();

            var leftSideTd = Page.Browser.TryFindElementBy(w => {
                var tDs = w.FindElements(By.XPath("//td[@class='crf_rowLeftSide']"));
                var tD = tDs.FirstOrDefault(x =>
                    x.Text.Split(new [] { "\r\n" }, StringSplitOptions.None)[0] == label);
                return tD;
            });

            if (leftSideTd == null)
                throw new Exception("Can't find field area:" + label);

            IWebElement result = null;
            foreach (var suffix in suffixParams)
            {
                result = leftSideTd.TryFindElementBy(
                    By.XPath("./../td[@class='crf_rowRightSide']//table[@class='crf_dataPointInternal']//*['"
                        + suffix +
                        "' = substring(@id, string-length(@id) - string-length('"
                        + suffix +
                        "') + 1)]"));

                if (result != null)
                    break;
            }
            
            return result;
        }


      
        #endregion


	}
}
