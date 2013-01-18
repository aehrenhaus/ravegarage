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
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.PageObjects.Rave
{
    public class FileRequestPage : RavePageBase, ICanPaginate, IVerifyRowsExist,IVerifySomethingExists
    {
        /// <summary>
        /// Create a new data pdf file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, Name dictates the data PDF's name</param>
        /// <returns>Returns a new FileRequestPage</returns>
        public FileRequestPage CreateDataPDF(PDFCreationModel args)
        {
            string linkText = "Create Data Request";
            if (!string.IsNullOrEmpty(args.Locale) && args.Locale.Equals("LLocalization Test",StringComparison.InvariantCultureIgnoreCase))
                linkText = string.Concat("L",linkText);

            ClickLink(linkText);
            return Context.CurrentPage.As<FileRequestCreateDataRequestPage>().CreateDataPDF(args);
        }

        /// <summary>
        /// Create a new blank pdf file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, Name dictates the data PDF's name</param>
        /// <returns>Returns a new FileRequestPage</returns>
        public FileRequestPage CreateBlankPDF(PDFCreationModel args)
        {
            string linkText = "Create Blank Request";
            if (!string.IsNullOrEmpty(args.Locale) && args.Locale.Equals("LLocalization Test", StringComparison.InvariantCultureIgnoreCase))
                linkText = string.Concat("L", linkText);

            ClickLink(linkText);

            return Context.CurrentPage.As<FileRequestCreateBlankRequestPage>().CreateBlankPDF(args);
        }

        /// <summary>
        /// Generate a pdf that has a file request
        /// </summary>
        /// <param name="pdf">The pdf that you want to generate, should already have a file request created</param>
        /// <returns>Returns this FileRequestPage</returns>
        public FileRequestPage Generate(string pdfName)
        {
            new PDFSpecific(SpecialStringHelper.Replace(pdfName));
            int foundOnPage;
            Table dt = new Table("Name");
            dt.AddRow(SpecialStringHelper.Replace(pdfName));

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
				HtmlTable table = Browser.TryFindElementByPartialID("Content_Results").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            ChooseFromCheckboxes("Live Status Update", true);
            
            EnhancedElement genButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("imgGenerateNow"));

            genButton.Click();
            Thread.Sleep(1000);
			Browser.GetAlertWindow().Accept();
            return this;
        }

        /// <summary>
        /// Edit a pdf 
        /// </summary>
        /// <param name="pdf">The pdf that you want to edit, should already have a file request created</param>
        /// <returns>Returns this FileRequestPage</returns>
        public FileRequestPage EditPdf(string pdfName)
        {
            int foundOnPage;
            Table dt = new Table("Name");
            dt.AddRow(pdfName);

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Browser.TryFindElementByPartialID("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            if (pdfTr == null)
            {
                dt = new Table("LName");
                dt.AddRow(pdfName);

                pdfTr = this.FindInPaginatedList("", () =>
                {
                    HtmlTable table = Browser.TryFindElementByPartialID("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                    return table.FindMatchRows(dt).FirstOrDefault();
                }, out foundOnPage);
            }

            EnhancedElement editButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("imgEdit"));

            editButton.Click();

            //Wait for save link on edit pdf page to make sure that edit pdf page has loaded
            Browser.TryFindElementById("_ctl0_Content_SaveLnkBtn", true, 10);
            return this;
        }



        #region IPaginatedPage

        //TODO: clean these vars, they are uesd in GoNextPage()
        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;
		public int CurrentPageNumber { get; private set; }
        public bool GoNextPage(string areaIdentifer)
        {
            HtmlTable table = Browser.TryFindElementByPartialID("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
            IWebElement pageTable = table.TryFindElementBy(By.XPath(".//tr[@align='center']"));
            ReadOnlyCollection<IWebElement> pageLinks = pageTable.FindElements(By.XPath(".//a|.//span"));

            count = pageLinks.Count;
            if (pageIndex == count)
                return false;

            while (!pageLinks[pageIndex].Text.Equals("...") && int.Parse(pageLinks[pageIndex].Text) <= lastValue && pageIndex <= count)
            {
                pageIndex++;
            }

            if (pageLinks[pageIndex].Text.Equals("..."))
            {
                lastValue = int.Parse(pageLinks[pageIndex - 1].Text);
                pageLinks[pageIndex].Click();
                pageIndex = 1;
            }
            else
            {
                string linkText = pageLinks[pageIndex].Text;
                pageLinks[pageIndex].Click();
                //Adding necessary check so that we make sure that new page is loaded properly
                IWebElement clickedSpanElem = Browser.TryFindElementBy(By.XPath(".//span[text()='" + linkText + "']"), true, 20);
                pageIndex++;
            }
            return true;
        }

        public bool GoPreviousPage(string areaIdentifer)
        {
            throw new NotImplementedException();
        }

        public bool GoToPage(string areaIdentifer, int page)
        {
            throw new NotImplementedException();
        }

        public bool CanPaginate(string areaIdentifier)
        {
            return true;
        }
        #endregion

        public FileRequestPage WaitForPDFComplete(string pdf)
        {
            Thread.Sleep(1000);
            var table = Browser.Table("_ctl0_Content_Results");
            Table dt = new Table("Name");
            dt.AddRow(pdf);
            var tr = table.FindMatchRows(dt).FirstOrDefault();

            int waitTime = 240;
            var ele  = Browser.TryFindElementBy(b =>
                tr.Spans().FirstOrDefault(x => x.GetAttribute("id").EndsWith("StatusValue") && x.Text == "Completed"),
              true, waitTime
                );
			if (ele == null)
				throw new Exception("Did not complete in time(" + waitTime + "s)");

            return this;
        }

        /// <summary>
        /// Open the generated pdf and load its text into ScenarioText.
        /// </summary>
        /// <param name="pdf">The name of the pdf of be viewed</param>
        /// <returns></returns>
        public void ViewPDF(string pdf)
        {
            ClickLink("My PDF Files");
            FileRequestViewPage page = new FileRequestViewPage();
            page.ViewPDF(pdf);
        }

        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "Live Status Update")
                return Browser.FindElementById("LiveStatusUpdate");

            var element = Browser.TryFindElementBy(By.XPath("//input[@title='" + identifier + "']"));

            if (element == null && areaIdentifier == "Display multiple log lines per page")
                element = FindCheckboxForLogForm(identifier);

            if (identifier != null && element == null)
                return base.GetElementByName(identifier, areaIdentifier, listItem);
            
            return element;
        }

        public override string URL
        {
            get
            {
                return "Modules/PDF/FileRequests.aspx";
            }
        }

        /// <summary>
        /// Expand the multiple log lines display to show/select log line form to be displayed per page
        /// </summary>
        public void ExpandDisplayMultipleLogLines()
        {
            var elem = Browser.TryFindElementById("CombineLogLinesFrms_LabelDiv");

            if (elem != null)
                elem.Click();

            // Wait for log line form div
            Browser.TryFindElementBy(By.XPath(".//div[contains(@id, 'CombineLogLinesFrms_div') and contains(@style, 'block')]"), true, 30);
        }

     

		bool IVerifyRowsExist.VerifyTableRowsExist(string tableIdentifier, Table matchTable)
		{
			bool allExists = false;
			if (tableIdentifier == "Display multiple log lines per page")
			{
				IEnumerable<FormModel> forms = matchTable.CreateSet<FormModel>();

				foreach (FormModel fm in forms)
				{
					allExists = VerifyDisplayLogLinesFormExist(fm.Form, fm.Checked);
					if (!allExists)
						break;
				}

				return allExists;
			}
			throw new NotImplementedException();
		}

		bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch)
		{
			if (areaIdentifier == null)
			{
                if (!exactMatch && Browser.FindElementByTagName("body").Text.Contains(identifier))
					return true;
				else
					return false;
			}
			throw new NotImplementedException();
		}

	    #region helper methods
        private bool VerifyDisplayLogLinesFormExist(string formName, bool? isChecked)
        {
            DisplayMultipleLogLinesControl disMulLLcontrol = new DisplayMultipleLogLinesControl(this);
            return disMulLLcontrol.VerifyFormExist(formName, isChecked);
        }

        private IWebElement FindCheckboxForLogForm(string formName)
        {
            DisplayMultipleLogLinesControl disMulLLcontrol = new DisplayMultipleLogLinesControl(this);
            return disMulLLcontrol.FindCheckboxForLogFrom(formName);
        }

        #endregion
    }
}
