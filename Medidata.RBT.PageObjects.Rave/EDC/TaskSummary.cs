using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
    public class TaskSummary : ControlBase
    {
        private readonly IWebElement _rootElement;

        public TaskSummary(IPage page) 
            : base(page)
        {
            _rootElement = base.Page.Browser.TryFindElementBy(
                By.XPath("//span[@id='_ctl0_Content_TsBox_CBoxC']/../../../../.."),true,
                timeOutSecond: 10);
        }

        private bool IsExpanded
        {
            get
            {
                var element = _rootElement.FindElement(
                By.Id("_ctl0_Content_TsBox_IsCollapsedInput"));
                var expandState = element.GetAttribute("value");

                return "1".Equals(expandState);
            }
        }
        public void Expand()
        {
            if (!this.IsExpanded)
            {
                var element = _rootElement.FindElement(
                    By.XPath(".//table[@iscollapsedinput='_ctl0_Content_TsBox_IsCollapsedInput']"));
                element.Click();

                //Make sure this table is loaded in before anything else is accessed within it
                base.Page.Browser.TryFindElementByXPath("//span[@id='_ctl0_Content_TsBox_CBoxC']/table");
            }
        }
        public void Collapse()
        {
            if (this.IsExpanded)
            {
                var element = _rootElement.FindElement(
                    By.XPath(".//table[@iscollapsedinput='_ctl0_Content_TsBox_IsCollapsedInput']"));
                element.Click();
            }
        }

        public TaskSummaryItem GetTaskSummaryItem(string category)
        {
            TaskSummaryItem result = null;

            var element = _rootElement.FindElement(
                By.XPath(string.Format(
                    ".//div[span[text()='{0}']]", 
                    category)));
            
            var pageCountElement = element.FindElement(
                By.XPath("span[1]/span"));
                
            result = new TaskSummaryItem();
            result.PageCount = int.Parse(pageCountElement.Text);
            result.Task = category;

            return result;
        }
    }
}
