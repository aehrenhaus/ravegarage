using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.Architect
{
    public class EditChecksItem
    {
        private readonly IWebElement _editChecksItemContainer;

        public EditChecksItem(IWebElement container)
        {
            _editChecksItemContainer = container;
        }

        public string Name
        {
            get
            {
                var element = _editChecksItemContainer.FindElement(
                    By.XPath(".//td[1]/span"));
                return element.Text;
            }
        }
        public bool Publish 
        {
            get { return this.GetPublishCheckbox().Selected; }
            set
            {
                var checkbox = this.GetPublishCheckbox();
                if (value)
                    checkbox.Check();
                else
                    checkbox.Uncheck();
            }
        }
        public bool Run 
        {
            get { return this.GetRunCheckbox().Selected; }
            set 
            {
                var checkbox = this.GetRunCheckbox();
                if (value)
                    checkbox.Check();
                else
                    checkbox.Uncheck();
            } 
        }
        public bool Inactivate 
        {
            get { return this.GetInactivateCheckbox().Selected; }
            set
            {
                var checkbox = this.GetInactivateCheckbox();
                if (value)
                    checkbox.Check();
                else
                    checkbox.Uncheck();
            }
        }



        private Checkbox GetPublishCheckbox() 
        {
            var element = _editChecksItemContainer.FindElement(
                By.XPath(".//td[2]/span/input[contains(@id,'chkSelectCopy')]"));
            return element.EnhanceAs<Checkbox>();
        }
        private Checkbox GetRunCheckbox()
        {
            var element = _editChecksItemContainer.FindElement(
                By.XPath(".//td[3]/span/input[contains(@id,'chkSelectRun')]"));
            return element.EnhanceAs<Checkbox>();
        }
        private Checkbox GetInactivateCheckbox()
        {
            var element = _editChecksItemContainer.FindElement(
                By.XPath(".//td[4]/span/input[contains(@id,'chkSelectInactivate')]"));
            return element.EnhanceAs<Checkbox>();
        }
    }
}
