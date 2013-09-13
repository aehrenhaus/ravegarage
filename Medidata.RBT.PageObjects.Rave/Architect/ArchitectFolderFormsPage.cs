using System;
using System.Linq;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using OpenQA.Selenium;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectFolderFormsPage : ArchitectBasePage, IVerifyRowsExist
	{
		public override string URL
		{
			get
			{
                return "Modules/Architect/FolderForms.aspx";
			}
		}

        public bool VerifyTableRowsExist(string tableIdentifier, Table matchTable, int? amountOfTimes = null)
        {
            bool result = false;

            if (!amountOfTimes.HasValue || amountOfTimes.Value == 1)
            {
                if (tableIdentifier.Equals("FolderForms", StringComparison.InvariantCultureIgnoreCase))
                {
                    IWebElement folderFormsTable = Browser.TryFindElementById("_ctl0_Content_InnerTable");

                    result = VerifyFoldersExsit(folderFormsTable, matchTable);

                    if (result)
                        result = VerifyFormsExistenceInFolder(folderFormsTable, matchTable);
                }

            }

            return result;
        }

        private bool VerifyFoldersExsit(IWebElement folderFormsTable, Table matchTable)
        {
            bool result = false;
            //verify all the specified folders exist on the folder forms page
            var aTagsFolderElems = folderFormsTable.TryFindElementsBy(By.XPath("./tbody/tr[position() = 1]/td/a"));

            //We want to skip the first header as forms folder table has no folder specified in the first column header
            //as it corresponds to forms column 
            for (int folderIndex = 1; folderIndex < matchTable.Header.Count; folderIndex++)
            {
                result = aTagsFolderElems.Any(a => a.Text.Equals(matchTable.Header.ElementAt(folderIndex)));

                if (!result)
                    break;
            }

            return result;
        }

        private bool VerifyFormsExistenceInFolder(IWebElement folderFormsTable, Table matchTable)
        {
            bool result = false;

            //verify all the specified forms exist on the folder forms page
            var aTagsFormElems = folderFormsTable.TryFindElementsBy(By.XPath("./tbody/tr/td[position() = 1]/a"));

            for (int formIndex = 0; formIndex < matchTable.Rows.Count; formIndex++)
            {
                result = aTagsFormElems.Any(a => a.Text.Equals(matchTable.Rows[formIndex][matchTable.Header.ElementAt(0)]));

                if (result)
                {
                    var checkUncheckTds = folderFormsTable.TryFindElementsBy(
                        By.XPath(string.Format("./tbody/tr[position() = {0}]/td", formIndex + 2)));

                    for (int folderIndex = 1; folderIndex < matchTable.Rows[formIndex].Values.Count; folderIndex++)
                    {
                        result = VerifySelected(checkUncheckTds.ElementAt(folderIndex), matchTable.Rows[formIndex][folderIndex]);

                        if (!result)
                            break;
                    }

                }

                if (!result)
                    break;
            }

            return result;
        }

        private bool VerifySelected(IWebElement tdElem, string selected)
        {
            switch (selected.ToLower())
            {
                case "":
                case null:
                case "unchecked":
                    return tdElem.Text.Equals(string.Empty) && 
                        tdElem.TryFindElementBy(By.XPath("./img"), false) == null;
                case "checked":
                    return tdElem.TryFindElementBy(
                        By.XPath("./img[contains(@src, 'i_check.gif')]")) != null;
                default:
                    throw new ArgumentOutOfRangeException(string.Format("Specified argument [{0}] is not valid.", selected));
            }
        }
    }
}
