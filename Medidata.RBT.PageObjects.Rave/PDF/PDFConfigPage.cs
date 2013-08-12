using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.PDF
{
    /// <summary>
    /// PDFConfigProfilesPage object to manage Rave pdf configuration
    /// related functionality
    /// </summary>
    public class PDFConfigPage : RavePageBase
    {
        /// <summary>
        /// url for pdf config profiles page
        /// </summary>
        public override string URL
        {
            get
            {
                return "Modules/Configuration/PDFConfig.aspx";
            }
        }

        /// <summary>
        /// Edit the pdf config properties. Do not do anything here that could be done through upload.
        /// </summary>
        /// <param name="coverPageLogo">The cover page logo, must be in the images folder</param>
        /// <param name="headerImage">The header image, must be in the images folder</param>
        public void EditDocumentProperties(string coverPageLogo, string headerImage)
        {
            Browser.TryFindElementById("DocumentPropertiesNav").Click();

            Context.Browser.FindElementById("Content_PDFConfigForm_CoverPageLogo_ImgPath")
                .SendKeys(RBTConfiguration.Default.UploadPath + @"\Images\" + coverPageLogo);
            Context.Browser.FindElementById("Content_PDFConfigForm_HeaderImage_ImgPath")
                .SendKeys(RBTConfiguration.Default.UploadPath + @"\Images\" + headerImage);
            ClickButton("Save");
        }
    }
}
