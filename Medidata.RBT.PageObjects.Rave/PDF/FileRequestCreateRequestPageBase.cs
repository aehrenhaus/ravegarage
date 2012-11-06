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
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class FileRequestCreateRequestPageBase : RavePageBase
    {
        /// <summary>
        /// Method to be used by class deriving from FileRequestCreateRequestPageBase
        /// this method takes care of common pdf creation steps for blank and data pdf files
        /// </summary>
        /// <param name="args"></param>
        protected void CreatePDF(PDFCreationModel args)
        {
            if (!string.IsNullOrEmpty(args.Name))
                Type("Name", args.Name);
            if (!string.IsNullOrEmpty(args.Profile))
            {
                string profileName = TestContext.GetExistingFeatureObjectOrMakeNew
                    ( args.Profile, () => new PdfProfile(args.Profile)).UniqueName;

                ChooseFromDropdown("_ctl0_Content_FileRequestForm_ConfigProfileID", profileName);
            }
            if (!string.IsNullOrEmpty(args.Study))
            {
                string studyName = TestContext.GetExistingFeatureObjectOrMakeNew
                    (args.Study, () => new Project(args.Study)).UniqueName;
                if (args.Environment != null)
                {
                    studyName = studyName + " (" + args.Environment + ")";
                    ChooseFromDropdown("Study", studyName);
                }
                else
                {
                    var element = Browser.DropdownById("Study", true);
                    element.SelectByPartialText(studyName);
                }
            }
            if (!string.IsNullOrEmpty(args.Locale))
                ChooseFromDropdown("Locale", args.Locale);
            if (!string.IsNullOrEmpty(args.Role))
            {
                var dlRole = Browser.FindElementById("Role");
                Thread.Sleep(1000);

                string roleName = TestContext.GetExistingFeatureObjectOrMakeNew
                    (args.Role, () => new Role(args.Role)).UniqueName;

                ChooseFromDropdown("Role", roleName);
            }
        }
    }
}
