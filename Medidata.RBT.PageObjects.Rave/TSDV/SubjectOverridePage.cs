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
    public class SubjectOverridePage : SubjectManagementPageBase,IHavePaginationControl
    {

		public void CheckRepeatPattern(int blockSize, IEnumerable<TierPattern> tiers)
	    {
			//collect all subject tier names
		    var tierNames = GetTierNamesFromAllPages();
			int roundCount = (int) Math.Ceiling(tierNames.Count*1.0/blockSize);

			for (int i = 0; i < roundCount; i++)
			{
				var itemsInThisRound = tierNames.Skip(i*blockSize).Take(blockSize).ToList();

				foreach (var tier in tiers)
				{
					Assert.AreEqual(tier.NumberOfOccurrence, itemsInThisRound.Count(x => x == tier.TierName),
					                string.Format("Tier {0} does not have expected subject count {1}.", tier.TierName,
					                              tier.NumberOfOccurrence));
				}
			}
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

	    private List<string> GetTierNamesFromAllPages()
	    {
			var tierNames = new List<string>();
			int page;
			this.FindInPaginatedList(null, () =>
			{
				var subjectsDiv = Browser.TryFindElementBy(By.Id("SubjectOverrideDiv"));

				var itemsOnThisPage =
					subjectsDiv.FindElementsByPartialId("OriginalBlockTierIdLable").Select(x => x.Text).ToList();
				tierNames.AddRange(itemsOnThisPage);
				return null;
			}
			, out page);

			return tierNames;
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

		    var tierNames = GetTierNamesFromAllPages();
			
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

		public ICanPaginate GetPaginationControl(string areaIdentifier)
		{
			var pageTable = TestContext.Browser.TryFindElementByPartialID("PagingHolder", true, 2);
			return new RavePaginationControl_CurrentPageNotLink(this, pageTable);
		}
		
		#endregion

	
	}
}
