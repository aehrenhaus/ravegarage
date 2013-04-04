using System;
using System.Linq;
using System.Collections.Generic;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CheckQuickEditPage : ArchitectBasePage
    {
        /// <summary>
        /// Method to enter text into Quick Edit
        /// </summary>
        /// <param name="text"></param>
        public void EnterIntoQuickEdit(string text)
        {
            this.Browser.TryFindElementById("_ctl0_Content_TxtQuickEdit").SetInnerHtml(text);
        }

        public override string URL
        {
            get
            {
                return "Modules/Architect/CheckQuickEdit.aspx";
            }
        }
    }
}
