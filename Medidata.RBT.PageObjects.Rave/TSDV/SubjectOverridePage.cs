﻿using System;
using System.Collections.Generic;
using System.Data;
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
 
		public void CheckRepeatPattern(int blockSize, IEnumerable<Permutations> permutationses)
	    {
			
			List<string> all= new List<string>();
			foreach (var p in permutationses)
			{
				string[] parts = p.RandomizationPermutations.Split(',').Select(x=>x.Trim()).ToArray();
				if (parts.Length != blockSize)
					throw new Exception(string.Format("Permutation {0} does not have {1} slots", p.RandomizationPermutations, blockSize));
				all.Add(string.Join(",", parts));
			}
			//collect all subject tier names
			var tierNames = GetTierNames();
			int roundCount = (int) Math.Ceiling(tierNames.Count*1.0/blockSize);

			for (int i = 0; i < roundCount; i++)
			{
				var itemsInThisRound = tierNames.Skip(i*blockSize).Take(blockSize).Select(x=>x.Split('(')[0].Trim()).ToArray();

				string permutation = string.Join(",", itemsInThisRound);

				Assert.IsTrue(all.Contains(permutation),permutation+" is not in the list");
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

	    private List<string> GetTierNames()
	    {

			var link = Browser.TryFindElementById("_ctl0_PgHeader_TabTable").Links()[0];
			string href = link.Href;
			string studyID = href.Split('=')[1];

			string siteGroupName = Browser.TryFindElementById("_ctl0_Content_HeaderControl_slSiteGroup_TxtBx").GetAttribute("value");
			string siteName = Browser.TryFindElementById("_ctl0_Content_HeaderControl_slSite_TxtBx").GetAttribute("value");


			var table = DbHelper.ExecuteDataSet(string.Format(@"
declare               
    @StudyID INT ={0},          

    @SubjectSearch nvarchar(1000) = null,               
    @Locale char(3) = 'eng'
       
 select tbs.SubjectId,               
   case               
    when  tbs.ExcludedStatusId is null then s.SubjectName              
    else s.SubjectName + ' - ' + dbo.fnLocalString('tsdv_Excluded', @locale) + ' ' +               
    lds.String + ' ' + dbo.fnLocalString('tsdv_Status', @locale)              
    end as  SubjectName,         
  dbo.fnLocalDataString(sts.sitenameid, @Locale) as siteName,             
   dbo.fnLocalDataString(sg.sitegroupnameid, @Locale) as sitegroup,                    
 tbs.BlockTierId,                
     OriginalBlockTierId,                
     case                 
      when origTbt.TierTypeId = 1 then dbo.fnLocalString('tsdv_AllForms', @locale) + ' (' + dbo.fnLocalString('tsdv_DefaultTier', @locale) + ')'                
      when origTbt.TierTypeId = 2 then dbo.fnLocalString('tsdv_NoForms', @locale) + ' (' + dbo.fnLocalString('tsdv_DefaultTier', @locale) + ')'                
      when origTbt.TierTypeId = 3 then dbo.fnLocalString('tsdv_UseArchitect', @locale) + ' (' + dbo.fnLocalString('tsdv_DefaultTier', @locale) + ')'                
      when origTbt.TierTypeId = 4 then dbo.fnLocalDataString(origTct.tiernameid, @locale) + ' (' + dbo.fnLocalString('tsdv_CustomTier', @locale) + ')'                
     end as OriginalTierName,                 
     case                 
      when tbt.TierTypeId = 1 then dbo.fnLocalString('tsdv_AllForms', @locale) + ' (' + dbo.fnLocalString('tsdv_DefaultTier', @locale) + ')'                
      when tbt.TierTypeId = 2 then dbo.fnLocalString('tsdv_NoForms', @locale) + ' (' + dbo.fnLocalString('tsdv_DefaultTier', @locale) + ')'                
      when tbt.TierTypeId = 3 then dbo.fnLocalString('tsdv_UseArchitect', @locale) + ' (' + dbo.fnLocalString('tsdv_DefaultTier', @locale) + ')'                
      when tbt.TierTypeId = 4 then dbo.fnLocalDataString(tct.tiernameid, @locale) + ' (' + dbo.fnLocalString('tsdv_CustomTier', @locale) + ')'                
     end as TierName,                 
     tbs.OverrideReason,              
     tbs.ExcludedStatusId,                
     tbs.Active,                
     tbs.Updated,                
     dbo.fnFormatUserName(u.FirstName, u.MiddleName, u.LastName, null, null, null, loc.NameFormat) as username,      
  tct.CustomTierId as CustomTierId,      
  bp.Activated as ActivePlan,  
  tbt.TierTypeId  
 from TSDV_BlockSubjects tbs                
 join TSDV_BlockTiers tbt on tbs.BlockTierId = tbt.BlockTierId         
 join TSDV_Blocks tb on tb.BlockId = tbt.BlockId      
 join TSDV_BlockPlans bp on tb.BlockPlanId = bp.BlockPlanId              
 left join TSDV_CustomTiers tct on tbt.CustomTierId = tct.CustomTierId                
 join Subjects s on s.SubjectID = tbs.SubjectId and s.SubjectActive = 1                 
 join StudySites ss on ss.StudySiteID = s.StudySiteID                 
 join Sites sts on ss.SiteId = sts.SiteID          
 join SiteGroups sg on sg.SiteGroupId = sts.SiteGroupId          
 --join dbo.fnSiteGroupChildrenRecursive() sgr on sg.SiteGroupID = sgr.ChildSiteGroupID          
 join Studies st on st.StudyID = ss.StudyID                
 join TSDV_BlockTiers origTbt on tbs.OriginalBlockTierId= origTbt.BlockTierId                
 left join TSDV_CustomTiers  origTct on origTbt.CustomTierId = origTct.CustomTierId                
 left join Users u on u.UserID = tbs.OverrideByUserId                
 join dbo.Localizations loc ON 1 = 1              
 left join TSDV_ExcludedSubjectStatuses tsdvEss on  tsdvEss.ExcludedStatusId = tbs.ExcludedStatusId              
 left JOIN SubjectStatus exss on  exss.SubjectStatusId = tsdvEss.SubjectStatusId              
 left join LocalizedDataStrings lds on exss.StringId =  lds.StringID and lds.Locale= @Locale             
 where loc.Locale = @Locale and  st.StudyID = @StudyID 

   
   
   
   
			                        ",studyID)).Tables[0];
			var names = table.Rows.Cast<DataRow>().Select(x=>new {
				Tier=x["tierName"].ToString(),
				SiteGroup=x["sitegroup"].ToString(),
				Site=x["sitename"].ToString()
			}).Where(x =>( x.Site == siteName|| siteName=="All Sites") && (x.SiteGroup == siteGroupName || siteGroupName == "All Site Groups")).Select(x => x.Tier).ToList();

			return names;
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

		    var tierNames = GetTierNames();
			
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
