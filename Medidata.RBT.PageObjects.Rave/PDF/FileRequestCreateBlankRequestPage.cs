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
using Medidata.RBT.PageObjects.Rave.TableModels.PDF;

namespace Medidata.RBT.PageObjects.Rave
{
    public class FileRequestCreateBlankRequestPage : FileRequestCreateRequestPageBase
	{
        /// <summary>
        /// Create a new blank PDF file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, Name dictates the data PDF's name</param>
        /// <returns>A new FileRequestPage</returns>
        public FileRequestPage CreateBlankPDF(PDFCreationModel args)
        {
            base.CreatePDF(args);
			//NOTE : Try to find a selected matrix from the Matrix dropdown before the form is saved. 
			//It is possible to save the form without Matrix selected but that causes an error while generating the blank pdf file.
			Func<IWebDriver, IWebElement> query = 
				wd => wd.FindElements(By.XPath("//select[@id='Matrix']/option"))
					.FirstOrDefault(element => element.Selected);

			var selectedMatrixOption = Browser.TryFindElementBy(query, isWait: true);
			if (selectedMatrixOption == null)
				throw new NotFoundException("Expected a selected matrix in Matrix dropdown but it was not found");

            Browser.TryFindElementByPartialID("SaveLnkBtn").Click();

            Browser.TryFindElementById("_ctl0_Content_SearchCriteriaLabel", true, 10);
            //To make sure saved pdf is avaialble in the list before we try to generate it
            Browser.Navigate().Refresh();

            return new FileRequestPage();
        }

        /// <summary>
        /// Perform specific PDF selections that are only viable for blank PDF
        /// </summary>
        /// <param name="args">The PDF arguments you want to select</param>
        public override void PerformPDFSpecificSelections(PDFCreationModel args)
        {
            SelectCRFVersion(args.CRFVersion);
        }

        /// <summary>
        /// select the crf version for the blank pdf generator
        /// </summary>
        /// <param name="crfVersion"></param>
        public void SelectCRFVersion(string crfVersion)
        {
            if (!string.IsNullOrEmpty(crfVersion))
            {
                Dropdown crfVersionDropdown = Browser.DropdownById("CRFVersion", true);
                crfVersionDropdown.SelectByPartialText(SeedingContext.GetExistingFeatureObjectOrMakeNew<CrfVersion>(crfVersion, () => null).UniqueName);
            }
        }

        public override string URL
        {
            get { return "Modules/PDF/FileRequest.aspx?Type=Blank"; }
        }
	}
}
