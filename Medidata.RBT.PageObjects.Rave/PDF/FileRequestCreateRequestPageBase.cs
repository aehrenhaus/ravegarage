﻿using System;
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
using Medidata.RBT.PageObjects.Rave.TableModels.PDF;

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
            SelectPDFName(args.Name);
            SelectPDFProfile(args.Profile);
            SelectStudy(args.Study, args.Environment);
            SelectLocale(args.Locale);
            SelectRole(args.Role);
            PerformPDFSpecificSelections(args);
            if(args.FormExclusions != null)
                SelectFormExclusions(args.FormExclusions.Split(',').ToList());
            if (args.FolderExclusions != null)
                SelectFolderExclusions(args.FolderExclusions.Split(',').ToList());
        }

        /// <summary>
        /// Perform specific PDF selections that are only viable for either data PDF or blank PDF
        /// </summary>
        /// <param name="args">The PDF arguments you want to select</param>
        public abstract void PerformPDFSpecificSelections(PDFCreationModel args);

        /// <summary>
        /// Enter the desired pdf name in the textbox
        /// </summary>
        /// <param name="pdfName"></param>
        public void SelectPDFName(string pdfName)
        {
            if (!string.IsNullOrEmpty(pdfName))
                Type("Name", pdfName);
        }

        /// <summary>
        /// Select the profile name from the dropdown, this feature uses seeding
        /// </summary>
        /// <param name="pName"></param>
        public void SelectPDFProfile(string pName)
        {
            if (!string.IsNullOrEmpty(pName))
            {
                string profileName = SeedingContext.GetExistingFeatureObjectOrMakeNew
                    ( pName, () => new PdfProfile(pName)).UniqueName;

                ChooseFromDropdown("_ctl0_Content_FileRequestForm_ConfigProfileID", profileName);
            }
        }

        /// <summary>
        /// Select the study name with/without environment form the dropdown, this feature uses seeding
        /// to generate pdf
        /// </summary>
        /// <param name="sName"></param>
        /// <param name="envName"></param>
        public void SelectStudy(string sName, string envName)
        {
            if (!string.IsNullOrEmpty(sName))
            {
                string studyName = SeedingContext.GetExistingFeatureObjectOrMakeNew
                    (sName, () => new Project(sName)).UniqueName;
                if (envName != null)
                {
                    studyName = studyName + " (" + envName + ")";
                    ChooseFromDropdown("Study", studyName);
                }
                else
                {
                    var element = Browser.DropdownById("Study", true);
                    element.SelectByPartialText(studyName);
                }
            }
        }

        /// <summary>
        /// Select the locale for the pdf generator
        /// </summary>
        /// <param name="locale"></param>
        public void SelectLocale(string locale)
        {
            if (!string.IsNullOrEmpty(locale))
                ChooseFromDropdown("_ctl0_Content_FileRequestForm_Locale", locale);
        }

        /// <summary>
        /// Select the role from the dropdown for the pdf generator, this feature uses seeding
        /// </summary>
        /// <param name="role"></param>
        public void SelectRole(string role)
        {
            if (!string.IsNullOrEmpty(role))
            {
                var dlRole = Browser.FindElementById("Role");
                Thread.Sleep(1000);

                string roleName = SeedingContext.GetExistingFeatureObjectOrMakeNew
                    (role, () => new Role(role)).UniqueName;

                ChooseFromDropdown("Role", roleName);
            }
        }

        /// <summary>
        /// Select the form exclusions for the pdf generator
        /// </summary>
        /// <param name="formExclusions">List of forms to exclude</param>
        public void SelectFormExclusions(List<string> formExclusions)
        {
            //Open Form Exclusions box if it isn't already open
            IWebElement formsDiv = Browser.TryShowArea("Forms_div", "Forms_ShowHideBtn");
            foreach (string formToExclude in formExclusions)
            {
                //get checkbox next to form and check it
                formsDiv.TryFindElementBy(By.XPath(".//td[contains(text(), '" + formToExclude.Trim() + "')]/../td/input")).EnhanceAs<Checkbox>().Check();
            }
        }

        /// <summary>
        /// Select the folder exclusions for the pdf generator
        /// </summary>
        /// <param name="folderExclusions">List of forms to exclude</param>
        public void SelectFolderExclusions(List<string> folderExclusions)
        {
            //Open Form Exclusions box if it isn't already open
            IWebElement formsDiv = Browser.TryShowArea("Folders_div", "Folders_ShowHideBtn");
            foreach (string folderToExclude in folderExclusions)
            {
                //get checkbox next to form and check it
                formsDiv.TryFindElementBy(By.XPath(".//td[contains(text(), '" + folderToExclude.Trim() + "')]/../td/input")).EnhanceAs<Checkbox>().Check();
            }
        }

        protected string PrependLocalization(string stringToLocalize)
        {
            return string.Concat("L", stringToLocalize);
        }
    }
}
