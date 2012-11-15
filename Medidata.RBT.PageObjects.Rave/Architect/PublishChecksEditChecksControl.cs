using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave.Architect
{
    public class PublishChecksEditChecksControl
        : ControlBase
    {
        private IWebElement _editChecksContainer;
 
        public PublishChecksEditChecksControl(IPage page) : base(page) 
        {
            try
            {
                _editChecksContainer = this.Page.Browser.FindElement(
                    By.XPath("//div[@id='_ctl0_Content_pnlGrid']/div/table/tbody"));
            }
            catch { throw new NoSuchElementException("The Edit Checks control was not found on this page"); }
        }




        public void SelectForm(string form)
        {
            _editChecksContainer.FindElement(By.Id("_ctl0_Content_ddlForms"))
                .EnhanceAs<Dropdown>()
                .SelectByText(form);
        }

        public void Search()
        {
            _editChecksContainer.FindElement(
                By.Id("_ctl0_Content_btnSearch"))
                .Click();
        }

        public EditChecksItem FindEditChecksItemByName(string name)
        {
            try
            {
                var element = _editChecksContainer.FindElement(
                    By.XPath(".//table[@id='_ctl0_Content_dgObjects']/tbody/tr/td[1]/span[text()='" + name + "']/../.."));
                return new EditChecksItem(element);
            }
            catch { throw new NotFoundException("Edit Check item with the name [" + name + "] was not found"); }
        }
    }
}
