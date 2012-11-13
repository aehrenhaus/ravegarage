using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
    public class SubjectOverridePage : SubjectManagementPageBase,ICanPaginate
    {
		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if (identifier == "Search")
                return Browser.FindElementById("_ctl0_Content_HeaderControl_SearchLabel");
            return base.GetElementByName(identifier, areaIdentifier,listItem);
        }

        public override IPage ChooseFromDropdown(string name, string text)
        {
            if (name == "Select Site")
            {
                Browser.TextboxById("_ctl0_Content_HeaderControl_slSite_TxtBx").SetText(text);
                Browser.FindElementById("_ctl0_Content_HeaderControl_slSite").Textboxes()[1].Click();
                var option = Browser.TryFindElementBy(b =>
					b.FindElements(By.XPath("//div[@id='_ctl0_Content_HeaderControl_slSite_PickListBox']/div"))
					.FirstOrDefault(elm => elm.Text == text));
                option.Click();

            }
            else if (name == "Select Site Group")
            {
                Browser.TextboxById("_ctl0_Content_HeaderControl_slSiteGroup_TxtBx").SetText(text);
                Browser.FindElementById("_ctl0_Content_HeaderControl_slSiteGroup").Textboxes()[1].Click();
                var option = Browser.TryFindElementBy(b => 
					b.FindElements(By.XPath("//div[@id='_ctl0_Content_HeaderControl_slSiteGroup_PickListBox']/div"))
					.FirstOrDefault(elm => elm.Text == text));
                option.Click();

            }
            return this;
        }


        /// <summary>
        /// Determines whether enrolled subjects have been randomized on initla enrollment top the site.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <returns>
        ///   <c>true</c> if [is subjects randomized] [the specified table]; otherwise, <c>false</c>.
        /// </returns>
        public bool IsSubjectsRandomized(Table table)
        {
            bool IsSubjectsRandomized = false;
            var subjectsDiv = Browser.TryFindElementBy(By.Id("SubjectOverrideDiv"));
            foreach (TableRow row in table.Rows)
            {
                IWebElement rowTable = subjectsDiv.TryFindElementByPartialID(String.Format("_ctl{0}_SubjectOverrideItemsTable", row[1]));
                if (rowTable != null)
                {
                    IsSubjectsRandomized = !rowTable.FindElements(By.TagName("td"))[2].Text.Trim().ToLower().Contains(row[0].ToString().Trim().ToLower());
                    if (IsSubjectsRandomized) 
                        break;
                }
            }

            return IsSubjectsRandomized;
        }

        /// <summary>
        /// This method is to check whether there is a pattern for subject allocation or not.  
        /// </summary>
        /// <returns>
        ///   <c>true</c> if there is a pattern (bad), otherwise, <c>false</c>.
        /// </returns>
		public void AsserEachGroupOfSubjectsHaveDifferentTierNames(int rowsOfGroup, int rowsTotal)
        {
			//collect all subject tier names
			int pageSize = 20;
			int currentIndex = 0;
			var tierNames = new List<string>();

	        while (true)
	        {
				var subjectsDiv = Browser.TryFindElementBy(By.Id("SubjectOverrideDiv"));

				tierNames.AddRange(subjectsDiv.FindElementsByPartialId("OriginalBlockTierIdLable").Select(x => x.Text));

				currentIndex += pageSize;

				if (currentIndex < rowsTotal)
				{
					GoNextPage(null);
				}
				else
				{
					
					break;
				}
	        }
			
			//verify no pattern exists
			int groupCount =  rowsTotal / rowsOfGroup;
			for (int i = 0; i < groupCount - 1; i++)
			{
				var thisGroup = tierNames.GetRange(i * rowsOfGroup, rowsOfGroup).ToArray();
				var nextGroup = tierNames.GetRange((i+1) * rowsOfGroup, rowsOfGroup).ToArray();
				CollectionAssert.AreNotEqual(thisGroup, nextGroup, string.Format("group {0} and group {1} are found to be have same sequence of tiers", i+1,i+2));
			
			}


        }

        public override string URL
        {
            get
            {
                return "Modules/Reporting/TSDV/SubjectOverride.aspx";
            }
        }


		#region Pagination
		int pageIndex = 0;
		int count = 0;
		int lastValue = -1;

		public bool GoNextPage(string areaIdentifier)
		{
			var pageTable = TestContext.Browser.TryFindElementByPartialID("Content_TblPage");

			var pageLinks = pageTable.FindElements(By.XPath(".//a"));

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
				pageIndex = 0;
			}
			else
			{
				pageLinks[pageIndex].Click();
				pageIndex++;
			}
			return true;
		}

		public bool GoPreviousPage(string areaIdentifier)
		{
			throw new NotImplementedException();
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
    }
}
