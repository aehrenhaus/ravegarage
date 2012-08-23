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
namespace Medidata.RBT.PageObjects.Rave
{
    public class FileRequestPage : RavePageBase, ICanPaginate
	{
        public bool CanPaginate(string areaIdentifier)
        {
            return true;
        }

		public FileRequestPage CreateDataPDF(PDFCreationModel args)
		{
			ClickLink("Create Data Request");
			var page = new FileRequestCreateDataRequestPage();
			return page.CreateDataPDF(args);
		}

        public FileRequestPage CreateBlankPDF(PDFCreationModel args)
        {
            ClickLink("Create Blank Request");
            var page = new FileRequestCreateBlankRequestPage();
            return page.CreateBlankPDF(args);
        }

		public FileRequestPage Generate(PDF pdf)
		{
            int foundOnPage;
            Table dt = new Table("Name");
            dt.AddRow(pdf.Name);

            IWebElement pdfTr = this.FindInPaginatedList("", () =>
            {
                HtmlTable table = Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                return table.FindMatchRows(dt).FirstOrDefault();
            }, out foundOnPage);

            ChooseFromCheckboxes(null, "Live Status Update", true);

            EnhancedElement genButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("imgGenerateNow"));

            genButton.Click();
            GetAlertWindow().Accept();
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

        public override void DeleteObjectOnPage(RemoveableObject removeableObject)
        {
            if(removeableObject.GetType() == typeof(PDF))
            {
                //Delete the file from the DB
                int foundOnPage;
                Table dt = new Table("Name");
                dt.AddRow(((PDF)removeableObject).Name);

                IWebElement pdfTr = this.FindInPaginatedList("", () =>
                {
                    HtmlTable table = Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                    return table.FindMatchRows(dt).FirstOrDefault();
                }, out foundOnPage);

                EnhancedElement deleteButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("Delete"));

                deleteButton.Click();
                GetAlertWindow().Accept();

                //Delete the File Request
                ClickLink("File Requests");
                pdfTr = this.FindInPaginatedList("", () =>
                {
                    HtmlTable table = Browser.WaitForElement("_ctl0_Content_Results").EnhanceAs<HtmlTable>();
                    return table.FindMatchRows(dt).FirstOrDefault();
                }, out foundOnPage);

                deleteButton = pdfTr.FindImagebuttons().FirstOrDefault(x => x.GetAttribute("id").EndsWith("Delete"));

                deleteButton.Click();
                GetAlertWindow().Accept();
            }
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
			this.WaitForElement(b =>
				tr.Spans().FirstOrDefault(x => x.GetAttribute("id").EndsWith("StatusValue") && x.Text == "Completed"),
				"Did not complete in time("+waitTime+"s)", waitTime
				);

			return this;
		}

		public void ViewPDF(string pdf)
		{
            ClickLink("My PDF Files");
            FileRequestViewPage page = new FileRequestViewPage();
            page.ViewPDF(pdf);
		}

		public override IWebElement GetElementByName(string name)
		{
			if (name == "Live Status Update")
				return Browser.FindElementById("LiveStatusUpdate");
			return base.GetElementByName(name);
		}

        public override string URL
        {
            get
            {
                return "Modules/PDF/FileRequest.aspx";
            }
        }
	}
}
