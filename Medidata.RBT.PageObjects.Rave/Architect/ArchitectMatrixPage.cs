using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.AmendmentManager;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using System.Collections.ObjectModel;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectMatrixPage : ArchitectBasePage, IVerifyRowsExist
	{
		public override string URL
		{
			get
			{
                return "Modules/Architect/Matrices.aspx";
			}
		}

        public override IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null, bool partial = false)
        {
            if (linkText.Equals("Folder Forms"))
            {
                IWebElement matrixGrid = Browser.TryFindElementByPartialID("MatrixGrid");
                IWebElement folderFormsLink = matrixGrid.TryFindElementByXPath(string.Format(
                    ".//tr/td[2][contains(text(),'{0}')]/../td/a/img[contains(@src, 'i_cdrill.gif')]", areaIdentifier));
                folderFormsLink.Click();
                return WaitForPageLoads();
            }
            return base.ClickLink(linkText, objectType, areaIdentifier, partial);
        }

        public bool VerifyTableRowsExist(string tableIdentifier, Table matchTable, int? amountOfTimes = null)
        {
            bool result = false;
            if (!amountOfTimes.HasValue || amountOfTimes.Value == 1)
            {
                if (tableIdentifier.Equals("Matrices", StringComparison.InvariantCultureIgnoreCase))
                {
                    result = VerifyMatrixGrid(matchTable.CreateSet<ArchitectMatrixModel>());
                }
            }

            return result;
        }

        private bool VerifyMatrixGrid(IEnumerable<ArchitectMatrixModel> matrices)
        {
            bool result = false;
           
            ReadOnlyCollection<IWebElement> matrixTrs = Browser.TryFindElementsBy(
                By.XPath("//table[contains(@id, 'MatrixGrid')]/tbody/tr"));

            foreach (ArchitectMatrixModel matrix in matrices)
            {
                IWebElement partialMatchTr = matrixTrs.FirstOrDefault(tr => VerifyMatrixStringDataPredicate(tr, matrix));

                result = partialMatchTr == null ? false : VerifyAllowAdd(partialMatchTr, matrix.AllowAdd);

                if (!result)
                    break;
             
            }

            return result;
        }

        private bool VerifyMatrixStringDataPredicate(IWebElement trElem, ArchitectMatrixModel matrix)
        {
            var tds = trElem.TryFindElementsBy(By.XPath("./td"));
            return tds.Any(td => td.Text.Equals(matrix.OID)) &&
            tds.Any(td => td.Text.Equals(matrix.Name)) &&
            tds.Any(td => td.Text.Equals(matrix.Max.ToString()));
        }

        private bool VerifyAllowAdd(IWebElement partialMatchTr, string allowAdd)
        {
            switch(allowAdd.ToLower())
            {
                case "":
                case null:
                case "unchecked":
                    return partialMatchTr.TryFindElementsBy(
                        By.XPath("./td/img[contains(@src, 'i_empty.gif')]")) != null;
                case "checked":
                    return partialMatchTr.TryFindElementsBy(
                        By.XPath("./td/img[contains(@src, 'i_check.gif')]")) != null;
                default:
                    throw new ArgumentOutOfRangeException(string.Format("Specified argument [{0}] is not valid.", allowAdd));
            }
        }
    }
}
