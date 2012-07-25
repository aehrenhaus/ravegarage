using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
    public class SubjectIncludePage : SubjectManagementPageBase
	{
		public const string repeaterCheckbox = "_ctl0_Content_SubjectIncludeRepeater__ctl{0}_Checkbox";
        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/SubjectInclude.aspx";
            }
        }

        public IPage IncludeSubjects(int num)
        {
            IWebElement elem = null;
            for (int i = 1; i <= num; i++)
            {
                elem = Browser.TryFindElementById(string.Format(repeaterCheckbox, i));
                if (elem != null)
                {
                    elem.EnhanceAs<Checkbox>().Check();
                }
            }
            this.ClickSpanLink("Include Subjects");
            this.GetAlertWindow().Accept();
            return this;
        }
	}
}
