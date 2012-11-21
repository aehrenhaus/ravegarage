using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using System.Collections.ObjectModel;
using System.Threading;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;


namespace Medidata.RBT.PageObjects.Rave
{
    public class PromptsPage : RavePageBase, ICanPaginate
	{
		public PromptsPage()
		{
		}

		public PromptsPage(string reportPOName)
		{
			this.reportPOName = reportPOName;
		}

		private string reportPOName;

		public PromptsPage SetParameter(string name, Table table)
		{
             int foundOnPage;
			
            IWebElement subjectLink = this.FindInPaginatedList(name, () =>
            {
			    var paraTR = FindParameterTr(name);

				Thread.Sleep(500);//wiat for while, although the TryFindElementByXPath will wait anyway, the Exception is always showing in debug mode

				//wait till the div div becomes visible, that means the table is loaded complete
				paraTR.TryFindElementByXPath("./td[position()=2]/table/tbody/tr[position()=2]/td/div[@style='display: block;']", true);

			    var tbl = paraTR.FindElements(By.XPath(".//td[@style='border-width:0px;border-collapse:collapse;']/table"))[1].EnhanceAs<HtmlTable>();


			    var matchRows = tbl.FindMatchRows(table);

			    foreach (var row in matchRows)
			    {
				    row.Checkboxes()[0].Click();
					return tbl; // return anthing but null, just let FindInPaginatedList() know that match found.
			    }
                return null;

            }, out foundOnPage);

            return this;
        }

		private IWebElement FindParameterTr(string name)
		{
			var paraTRs = Browser.FindElementsByXPath("/html/body/div[3]/div[2]/div/form/div/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr");
			var paraTR = paraTRs.FirstOrDefault(x => x.FindElement(By.XPath("./td")).Text == name + ":");

			if (paraTR == null)
				throw new Exception("Can not find argument block:"+name);

			//It's image button for some field, and img for other controls....
			var extendButton = paraTR
				.FindImagebuttons()
				.FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_small_right.gif"));
			if (extendButton == null)
				extendButton = paraTR
				.Images()
				.FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_small_right.gif"));
			
			//may be already clicked 
            if (extendButton != null)
            {
                extendButton.Click();

                var id = paraTR.GetAttribute("id");
                var filter = id.Substring(id.LastIndexOf('_'));
                filter += "_div";
                
                //Wait for this element to appear (it actually already exists 
                //but it has style='display:none') thus the second filter in the expath
                var el = paraTR.TryFindElementBy(
                    By.XPath(".//div[contains(@id, '" + filter + "') and contains(@style, 'block')]"));
            }
			return paraTR;
		}

		public PromptsPage SearchInParameter(string name, string value)
		{			
			var paraTR = FindParameterTr(name);
			//wait till the div div becomes visible, that means the table is loaded complete
			var div = Browser.TryFindElementByXPath("./td[position()=2]/table/tbody/tr[position()=2]/td/div[@style='display: block;']",true);

			var textbox = paraTR.TextboxById("SearchTxt");
			textbox.SetText(value);
			var btnSearch = paraTR.TryFindElementByPartialID("SearchBtn");
			btnSearch.Click();

			Browser.TryFindElementBy(b =>
			{

				var working = paraTR.TryFindElementByPartialID("Working2");
				if (working.GetCssValue("display") == "none")
					return working;
				return null;
			}
				);
			return this;
		}

		public PromptsPage SetParameter(string name, string value)
        {
            if ("Study".Equals(name)) { value = TestContext.GetExistingFeatureObjectOrMakeNew(value, () => new Project(value)).UniqueName; }
            else if ("Sites".Equals(name)) { value = TestContext.GetExistingFeatureObjectOrMakeNew(value, () => new Site(value)).UniqueName; }

            var paraTR = FindParameterTr(name);
            var textbox = paraTR.Textboxes()[0];

            if (textbox.GetAttribute("readonly") == "true")
            {
                //a datetime control
                //This is a hack 
                //Because selecting a date from the calendar control is hard
                //I fill the textbox directly. And 'readonly' must be removed before setting the text
                textbox.Element.RemoveAttribute("readonly");

                textbox.SetText(value);
                textbox.Click();
                var div = paraTR.TryFindElementByPartialID("LabelDiv");
                div.SetInnerHtml(value);
            }
            else
            {
                // a text box control

                textbox.SetText(value);

                paraTR.FindElement(By.XPath(".//input[contains(@id, '_SearchBtn')]")).Click();   //Click search

                var checkbox = paraTR.FindElement(By.XPath(".//tr/td[text()='" + value + "']/../td[1]/input"))
                    .EnhanceAs<Checkbox>();
                checkbox.Check();

                //This doesn;t even exist ???
                //var checkButton = paraTR
                //	.FindImagebuttons()
                //	.FirstOrDefault(x => x.GetAttribute("src").EndsWith("Img/i_ccheck.gif"));

                //checkButton.Click();
            }

            return this;
        }

        /// <summary>
        /// Generate a report. Extract the downloaded pdf, and save its contents in ScenarioText to be used later.
        /// </summary>
        /// <param name="visits">The name of the pdf file request to delete</param>
        /// <returns></returns>
        public void GenerateReport()
        {
            ClickButton("PromptsBox_iid_ShowHideBtn");
            Thread.Sleep(2000);
            ChooseFromCheckboxes("PromptsBox_iid_SelectAll", true, "PromptsBox_iid_div");
            ClickButton("Submit Report");

            List<String> extractedFilePaths;
            //This is for selenium to wait for the file download to finish. There is currently no better way to do this in selenium.
            //If you get a unexpected end of file issue, this is an intermittent issue.
            do
            {
                Thread.Sleep(5000);
				extractedFilePaths = Misc.UnzipAllDownloads();
            }
            while (extractedFilePaths.Count == 0);
                

            StringBuilder sb = new StringBuilder();

            foreach (string filePath in extractedFilePaths)
                if (filePath.ToLower().EndsWith(".pdf"))
                    sb.Append(new Medidata.RBT.PDF("TripReports", filePath).Text);

            TestContext.ScenarioText = sb.ToString();
        }
		#region Pagination
		public int CurrentPageNumber { get; private set; }

		public bool GoNextPage(string areaIdentifier)
        {
            IWebElement nextLink = null;

            if (areaIdentifier=="Subjects")
                nextLink = TestContext.Browser.TryFindElementById("PromptsBox_su_PageLink:Next");
            else
                nextLink = TestContext.Browser.TryFindElementById("PromptsBox_st_PageLink:Next");

            if (nextLink != null)
                nextLink.Click();
            else
                return false;

            return true;
        }

        public bool GoPreviousPage(string areaIdentifier)
        {
            var previousLink = TestContext.Browser.TryFindElementById("PromptsBox_st_PageLink:Prev");
            if (previousLink != null)
                previousLink.Click();
            else
                return false;

            return true;
        }

        public bool GoToPage(string areaIdentifier, int page)
        {
            throw new NotImplementedException();
        }

		public bool CanPaginate(string areaIdentifier)
		{
			return true;
		}
		#endregion

		public override string URL
        {
            get { return "Modules/Reporting/PromptsPage.aspx"; }
        }
    }
}
