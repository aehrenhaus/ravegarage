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
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.PageObjects.Rave
{
    public class FileRequestPage : RavePageBase, ICanPaginate, ICanVerifyExist
    {
        /// <summary>
        /// Create a new data pdf file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, Name dictates the data PDF's name</param>
        /// <returns>Returns a new FileRequestPage</returns>
        public FileRequestPage CreateDataPDF(PDFCreationModel args)
        {
            string linkText = "Create Data Request";
            if (!string.IsNullOrEmpty(args.Locale) && args.Locale == "LLocalization Test")
                linkText = string.Concat("L",linkText);

            ClickLink(linkText);
            var page = new FileRequestCreateDataRequestPage();
            return page.CreateDataPDF(args);
        }

        /// <summary>
        /// Create a new blank pdf file request
        /// </summary>
        /// <param name="args">The pdfCreationModel dictates what on the page gets set. For instace, Name dictates the data PDF's name</param>
        /// <returns>Returns a new FileRequestPage</returns>
        public FileRequestPage CreateBlankPDF(PDFCreationModel args)
        {
            string linkText = "Create Blank Request";
            if (!string.IsNullOrEmpty(args.Locale) && args.Locale == "LLocalization Test")
                linkText = string.Concat("L", linkText);

            ClickLink(linkText);

            var page = new FileRequestCreateBlankRequestPage();
            return page.CreateBlankPDF(args);
        }

        /// <summary>
        /// Generate a pdf that has a file request
        /// </summary>
        /// <param name="pdf">The pdf that you want to generate, should already have a file request created</param>
        /// <returns>Returns this FileRequestPage</returns>
        public FileRequestPage Generate(string pdfName)
        {
            new PDFSpecific(pdfName);
            int foundOnPage;
            Table dt = new Table("Name");
            dt.AddRow(pdfName);

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            ChooseFromCheckboxes("Live Status Update", true);

            EnhancedElement genButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("imgGenerateNow"));

            genButton.Click();
            GetAlertWindow().Accept();
            return this;
        }

        /// <summary>
        /// Edit a pdf 
        /// </summary>
        /// <param name="pdf">The pdf that you want to edit, should already have a file request created</param>
        /// <returns>Returns this FileRequestPage</returns>
        public FileRequestPage EditPdf(string pdfName)
        {
            new PDFSpecific(pdfName);
            int foundOnPage;
            Table dt = new Table("Name");
            dt.AddRow(pdfName);

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            if (pdfTr == null)
            {
                dt = new Table("LName");
                dt.AddRow(pdfName);

                pdfTr = this.FindInPaginatedList("", () =>
                {
                    HtmlTable table = Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                    return table.FindMatchRows(dt).FirstOrDefault();
                }, out foundOnPage);
            }

            EnhancedElement genButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("imgEdit"));

            genButton.Click();
            return this;
        }



        #region IPaginatedPage

        //TODO: clean these vars, they are uesd in GoNextPage()
        int pageIndex = 1;
        int count = 0;
        int lastValue = -1;

        public bool GoNextPage(string areaIdentifer)
        {
            HtmlTable table = Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
            IWebElement pageTable = table.FindElement(By.XPath(".//tr[@align='center']"));
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
                pageLinks[pageIndex].Click();
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

            int waitTime = 60;
            Browser.WaitForElement(b =>
                tr.Spans().FirstOrDefault(x => x.GetAttribute("id").EndsWith("StatusValue") && x.Text == "Completed"),
                "Did not complete in time(" + waitTime + "s)", waitTime
                );

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
            {
                element = FindCheckboxForLogForm(identifier);
            }

            if (element != null)
                return element;

            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }

        public override string URL
        {
            get
            {
                return "Modules/PDF/FileRequest.aspx";
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

            Thread.Sleep(1000);
            // Wait for log line form div
            Browser.WaitForElement(By.Id("CombineLogLinesFrms_div"));
        }

        public bool VerifyTableRowsExist(string tableIdentifier, Table matchTable)
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

        public bool VerifyControlExist(string identifier)
        {
            throw new NotImplementedException();
        }

        public bool VerifyTextExist(string identifier, string text)
        {
            if (identifier == null)
            {
                if (Browser.FindElementByTagName("body").Text.Contains(text))
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
