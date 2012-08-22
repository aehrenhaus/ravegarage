using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Threading;

namespace Medidata.RBT.PageObjects.Rave
{
	public class FileRequestCreateBlankRequestPage : RavePageBase
	{
        public FileRequestPage CreateBlankPDF(PDFCreationModel args)
        {
            if (!string.IsNullOrEmpty(args.Name))
                Type("Name", args.Name);
            if (!string.IsNullOrEmpty(args.Profile))
                ChooseFromDropdown("_ctl0_Content_FileRequestForm_ConfigProfileID", args.Profile);
            if (!string.IsNullOrEmpty(args.Study))
                ChooseFromDropdown("Study", args.Study);
            if (!string.IsNullOrEmpty(args.Role))
            {
                var dlRole = Browser.FindElementById("Role");
                Thread.Sleep(1000);
                ChooseFromDropdown("Role", args.Role);
            }
            if (!string.IsNullOrEmpty(args.Locale))
            {
                ChooseFromDropdown("Locale", args.Locale);
            }
            if (!string.IsNullOrEmpty(args.CRFVersion))
            {
                ChooseFromDropdown("CRFVersion", args.CRFVersion);
            }

            ClickLink("Save");
            return new FileRequestPage();
        }
	}
}
