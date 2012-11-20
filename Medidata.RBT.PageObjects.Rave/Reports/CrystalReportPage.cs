using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.PageObjects.Rave
{
    public class CrystalReportPage
		: RavePageBase, ICanPaginate, IVerifyRowsExist
	{
        public CrystalReportPage() { }
        
        public override string URL
        {
            get { return "CrystalReportViewer.aspx"; }
        }

        /// <summary>
        /// Verifies if any duplicate record exist in the crystal report
        /// </summary>
        /// <returns></returns>
        public bool VerifyDuplicateRecordsAreNotDisplayed()
        {
            bool result = false;
            List<string> rowContentList = new List<string>();

            try
            {   
                do
                {
                    //find the iframe to inspect the records
                    var iframe = this.Browser.FindElement(By.XPath("//iframe"));
                    var frameElem = this.Browser.SwitchTo().Frame(iframe);

                    var crystalDivElem = frameElem.FindElement(By.Id("crViewer__ctl1"));
                    crystalDivElem = crystalDivElem.FindElement(By.ClassName("crystalstyle"));
                    
                    //find all the children divs
                    if (crystalDivElem != null)
                    {
                        ReadOnlyCollection<IWebElement> divElems = crystalDivElem.FindElements(By.XPath("./div"));

                        rowContentList.AddRange(GetReportRows(divElems, "Record created.", "Record deleted."));
                    }
                    //find all the children divs

                } while (this.GoNextPage(null));

            }
            catch { return false; }

            IEnumerable<string> distinctRows = rowContentList.Distinct().ToList();

            result = distinctRows.Count().Equals(rowContentList.Count()) ? true : false;

            //Check if SYSTEM user has created a record 
            //this happens during Migration if duplicate records are created
            foreach (string rowCont in rowContentList)
            {
                if (result && rowCont.Contains("SYSTEM") &&
                    rowCont.Contains("Record created."))
                {
                    result = false;
                    break;
                }
            }


            return result;
        }


        #region pagination

		public int CurrentPageNumber { get; private set; }

	    public bool GoNextPage(string areaIdentifier)
        {
            return GoToPage("IconImg_crViewer_toptoolbar_nextPg");
        }

        public bool GoPreviousPage(string areaIdentifier)
        {
            return GoToPage("IconImg_crViewer_toptoolbar_prevPg");
        }

        public bool GoToPage(string areaIdentifier, int page)
        {
            throw new NotImplementedException();
        }

        public bool CanPaginate(string areaIdentifier)
        {
            return true;
        }

        /// <summary>
        /// This is a utility method used by Ipaginated implementation to navigate to next or previous page
        /// </summary>
        /// <param name="areaIdentifier"></param>
        /// <returns></returns>
        private bool GoToPage(string areaIdentifier)
        {
            bool result = false;
            //switch to default context
            this.Browser.SwitchTo().DefaultContent();

            //find the crf toolbar
            var elem = Browser.FindElementById("crViewer_toptoolbar");
            if (elem != null)
            {
                //find the go to next/previous control
                var goToNextElem = elem.FindElement(By.Id(areaIdentifier));
                if (goToNextElem != null)
                {
                    //check if cursor is pointer for this control
                    string cursorType = goToNextElem.GetCssValue("cursor");
                    if (cursorType.Equals("pointer", StringComparison.InvariantCultureIgnoreCase))
                    {
                        goToNextElem.Click();
                        //wait for page to load 
                        Browser.TryFindElementBy(By.Id("Logo1_HeaderImage"), true);
                        result = true;
                    }

                }
            }
            return result;
        }
        #endregion

        /// <summary>
        /// This method takes all the content of each row of the crystal report
        /// creates a string using space separation and any row constraint specified.
        /// All the row are returned as a list of strings
        /// </summary>
        /// <param name="elems"></param>
        /// <param name="rowConstraint"></param>
        /// <param name="separator"></param>
        /// <returns></returns>
        private List<string> GetReportRows(ReadOnlyCollection<IWebElement> elems,params string[] rowConstraints)
        {
            List<string> rowContentList = new List<string>();

            List<IWebElement> divElems = new List<IWebElement>();
            divElems.AddRange(elems);
            
            while (divElems.FirstOrDefault<IWebElement>(e => e.GetAttribute("id").Equals("Section3")) != null)
            {
                divElems = divElems.SkipWhile<IWebElement>(e => !e.GetAttribute("id").Equals("Section3")).ToList();
                divElems = divElems.Skip(1).ToList();
                
                List<IWebElement> contentElems = divElems.TakeWhile<IWebElement>(
                    e => !e.GetAttribute("id").Equals("Section3") || e.GetAttribute("id").Equals("Section5")).ToList();
               
                StringBuilder rowContentBuilder = new StringBuilder();
                foreach (var contElem in contentElems)
                {
                    //find all the spans
                    ReadOnlyCollection<IWebElement> spanElems = contElem.FindElements(By.XPath(".//span"));
                    foreach (var spanElem in spanElems)
                    {
                        rowContentBuilder.Append(string.Format("{0} ", spanElem.Text));
                    }
                }

                if (rowContentBuilder.Length > 0)
                {
                    if (rowConstraints.Length < 1)
                        rowContentList.Add(rowContentBuilder.ToString());
                    else
                    {
                        string rowContentStr = rowContentBuilder.ToString();
                        foreach (string rowConst in rowConstraints)
                        {
                            if (rowContentStr.Contains(rowConst))
                            {
                                rowContentList.Add(rowContentStr);
                                break;
                            }
                        }
                    }
                }
            }

            return rowContentList;
        }

        /// <summary>
        /// Checks each row in the report for the exact existence of each column and its value
        /// as given by the QueryAuditReportSearchModel instance. Returns true immediately after 
        /// the first match is found. Each column is checked assuming that if the Column is null, represented by the property in
        /// the QueryAuditReportSearchModel instance, it is a don't care condition.
        /// </summary>
        /// <param name="model">
        /// QueryAuditReportSearchModel instance representing the parameters that the method will match on.
        /// Each property represents a column in the report. If all the properties are null, the search will
        /// collapse into the trivial case where all the parameters are don't care conditions and the method will return True.
        /// </param>
        /// <returns>True only if at least one match exists</returns>
        private bool VerifyTableRowsExist(QueryAuditReportSearchModel model)
        {
            model.Site = TestContext.GetExistingFeatureObjectOrMakeNew(model.Site, 
                () => new Site(model.Site)).UniqueName;

            try
            {
                bool exists = false;    //Asume the row does not exist
                
                do
                {
                    var iframe = this.Browser.FindElement(By.XPath("//iframe"));
                    this.Browser.SwitchTo().Frame(iframe);

                    var rows = this.Browser.FindElements(By.XPath("//div[@id='Section3']"));
                    foreach (var row in rows)
                    {
                        if (ConfirmSite(row, model)
                            && ConfirmSiteGroup(row, model)
                            && ConfirmSubject(row, model)
                            && ConfirmFolder(row, model)
                            && ConfirmForm(row, model)
                            && ConfirmPageRptNumber(row, model)
                            && ConfirmField(row, model)
                            && ConfirmLogNo(row, model)
                            && ConfirmAuditAction(row, model)
                            && ConfirmAuditUser(row, model)
                            && ConfirmAuditRole(row, model)
                            && ConfirmAuditActionType(row, model)
                            && ConfirmAuditTime(row, model))
                        {
                            exists = true;
                            break;
                        }
                    }//End foreach
                }
                //Continue searching while there are more pages to look at and row wasn't found yet
                while (!exists
                    && this.GoNextPage(null));


                return exists;
            }
            catch (Exception ex)
            { 
                return false; 
            }
        }


        private bool ConfirmSite(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.Site == null is a don't care condition
            if (model.Site != null)
            {
                try
                {
                    var site = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field4'][1]"));
                    
                    var text = (site.Text ?? string.Empty)
                        .Replace("\r", string.Empty)
                        .Replace("\n", string.Empty)
                        .Trim();
                    result = model.Site.Equals(text);
                }
                catch { result = false; }   //The element isn't even there
            }

            return result;
        }
        private bool ConfirmSiteGroup(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.SiteGroup == null is a don't care condition
            if (model.SiteGroup != null)
            {
                try
                {
                    var siteGroup = row.FindElement(
                        By.XPath("./following-sibling::div[@id='SiteGroupName1'][1]"));
                    result = model.SiteGroup
                        .Equals(siteGroup.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmSubject(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.Subject == null is a don't care condition
            if (model.Subject != null)
            {
                try
                {
                    var subject = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field6'][1]"));
                    result = model.Subject
                        .Equals(subject.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmFolder(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.Folder == null is a don't care condition
            if (model.Folder != null)
            {
                try
                {
                    var folder = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field8'][1]"));
                    result = model.Folder
                        .Equals(folder.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmForm(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.Form == null is a don't care condition
            if (model.Form != null)
            {
                try
                {
                    var form = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field10'][1]"));
                    result = model.Form
                        .Equals(form.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmPageRptNumber(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.PageRptNumber == null is a don't care condition
            if (model.PageRptNumber.HasValue)
            {
                try
                {
                    var pageRptNumber = row.FindElement(
                        By.XPath("./following-sibling::div[@id='PageRepeatNumber1'][1]"));
                    result = model.PageRptNumber.ToString()
                        .Equals(pageRptNumber.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmField(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.Field == null is a don't care condition
            if (model.Field != null)
            {
                try
                {
                    var field = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field12'][1]"));
                    result = model.Field
                        .Equals(field.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmLogNo(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.LogNo == null is a don't care condition
            if (model.LogNo.HasValue)
            {
                try
                {
                    var logNo = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field13'][1]"));
                    result = model.LogNo.ToString()
                        .Equals(logNo.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmAuditAction(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.AuditAction == null is a don't care condition
            if (model.AuditAction != null)
            {
                try
                {
                    var auditAction = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field7'][1]"));

                    var text = (auditAction.Text ?? string.Empty)
                        .Replace("\r", string.Empty)
                        .Replace("\n", string.Empty)
                        .Trim();
                    result = model.AuditAction.Equals(text);
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmAuditUser(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.AuditUser == null is a don't care condition
            if (model.AuditUser != null)
            {
                try
                {
                    var auditUser = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field16'][1]"));
                    result = model.AuditUser
                        .Equals(auditUser.Text.Trim());
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmAuditRole(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.AuditRole == null is a don't care condition
            if (model.AuditRole != null)
            {
                try
                {
                    var auditRole = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field18'][1]"));
                    
                    var text = (auditRole.Text ?? string.Empty)
                        .Replace("\r", string.Empty)
                        .Replace("\n", string.Empty)
                        .Trim();
                    result = model.AuditRole.Equals(text);
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmAuditActionType(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.AuditActionType == null is a don't care condition
            if (model.AuditActionType != null)
            {
                try
                {
                    var auditActionType = row.FindElement(
                        By.XPath("./following-sibling::div[@id='Field5'][1]"));

                    var text = (auditActionType.Text ?? string.Empty)
                        .Replace("\r", string.Empty)
                        .Replace("\n", string.Empty)
                        .Trim();
                    result = model.AuditActionType.Equals(text);
                }
                catch { result = false; }
            }

            return result;
        }
        private bool ConfirmAuditTime(IWebElement row, QueryAuditReportSearchModel model)
        {
            var result = true;

            //model.AuditTime == null is a don't care condition
            if (model.AuditTime != null)
            {
                try
                {
                    var auditTime = row.FindElement(
                        By.XPath("./following-sibling::div[@id='AuditTimeLocalized1'][1]"));

                    var text = (auditTime.Text ?? string.Empty)
                        .Replace("\r", string.Empty)
                        .Replace("\n", string.Empty)
                        .Trim();

                    DateTime dt;
                    DateTime.TryParse(text, out dt);

                    result = text.Equals(dt.ToString(model.AuditTime));
                }
                catch { result = false; }
            }

            return result;
        }

        bool IVerifyRowsExist.VerifyTableRowsExist(string tableIdentifier, Table matchTable)
        {
			var result = true;
			var args = matchTable.CreateSet<QueryAuditReportSearchModel>();
			foreach (var arg in args)
				result &= this.VerifyTableRowsExist(arg);

			return result;
        }

    }
}
