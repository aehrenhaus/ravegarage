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

namespace Medidata.RBT.PageObjects.Rave
{
    public class CrystalReportPage : RavePageBase, ICanPaginate
    {
        public CrystalReportPage()
        {

        }
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

            return result;
        }


        #region pagination
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
            throw new NotImplementedException();
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
                        Browser.WaitForElement(By.Id("Logo1_HeaderImage"));
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

    }

    
}
