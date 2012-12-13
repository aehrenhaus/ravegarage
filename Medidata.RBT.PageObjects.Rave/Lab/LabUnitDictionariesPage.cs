using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Collections.ObjectModel;
namespace Medidata.RBT.PageObjects.Rave
{
    public class LabUnitDictionariesPage : LabPageBase, IVerifySomethingExists
    {
        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/LabUnitDictionaryPage.aspx";
            }
        }

        public void IAddNewLabUnitDictionaries(IEnumerable<ArchitectObjectModel> dictionaries)
		{
            foreach (var dictionary in dictionaries)
                AddLabUnitDictionary(dictionary.Name);   
		}

        /// <summary>
        /// Add a single lab unit dictionary
        /// </summary>
        /// <param name="dictionaryName">The name of the dictionary to add</param>
        public void AddLabUnitDictionary(string dictionaryName)
        {
            ClickLink("Add Lab Unit Dictionary");
            HtmlTable mainTable = Browser.TryFindElementById("_ctl0_Content_LabUnitDictionaryGrid").EnhanceAs<HtmlTable>();
            ReadOnlyCollection<IWebElement> mainTableRows = mainTable.Rows();
            mainTableRows[mainTableRows.Count - 2].Textboxes()[0].EnhanceAs<Textbox>().SetText(dictionaryName);
            Browser.LinkByPartialText("Update").Click();
        }

        public bool LabUnitDictionariesExistWithNames(IEnumerable<ArchitectObjectModel> dictionaries, int page = 1)
        {
            if (Browser.TryFindElementByLinkText(page.ToString()) != null)
                ClickLink(page.ToString());
            else if (page > 1)
                return false;
                
            bool found = false;
            foreach (var dictionary in dictionaries)
            {
                found = false;
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_LabUnitDictionaryGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(dictionary.Name))
                    {
                        found = true;
                        break;
                    }
                if (!found)
                {
                    return LabUnitDictionariesExistWithNames(dictionaries, page + 1);
                }
            }
            return found;
        }

        public bool LabUnitDictionariesDelete(IEnumerable<ArchitectObjectModel> dictionaries, int page = 1)
        {
            if (Browser.TryFindElementByLinkText(page.ToString()) != null)
                ClickLink(page.ToString());
            else if (page > 1)
                return false;

            bool found = false;
            foreach (var dictionary in dictionaries)
            {
                found = false;
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_LabUnitDictionaryGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(dictionary.Name))
                    {
                        row.Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();
                        Browser.TryFindElementBy(By.XPath(".//input[@type='checkbox' and contains(@id,'_chkDeleteDictionary')]")).EnhanceAs<Checkbox>().Check();  
                        Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                        found = true;
                        break;
                    }
                if (!found)
                {
                    return LabUnitDictionariesDelete(dictionaries, page + 1);
                }
            }
            if (!found)
            {
                throw new ArgumentOutOfRangeException("LabUnitDictionariesDelete cannot delete dictionaries");
            }
            return found;
        }

        public bool LabUnitDictionariesEdit(IEnumerable<ArchitectObjectModel> dictionaries, int page = 1)
        {
            if (Browser.TryFindElementByLinkText(page.ToString()) != null)
                ClickLink(page.ToString());
            else if (page > 1)
                return false;

            bool found = false;
            foreach (var dictionary in dictionaries)
            {
                found = false;
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_LabUnitDictionaryGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(dictionary.From))
                    {
                        row.Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();
                        Browser.TryFindElementByPartialID("_ctl0_Content_LabUnitDictionaryGrid__ct").EnhanceAs<Textbox>().SetText(dictionary.To);
                        Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                        found = true;
                        break;
                    }
                if (!found)
                {
                    return LabUnitDictionariesEdit(dictionaries, page + 1);
                }
            }
            if (!found)
                throw new ArgumentOutOfRangeException("LabUnitDictionariesDelete cannot delete dictionaries");
            return found;
        }

        #region ICanVerifyExist

		bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type,string identifier, bool exactMatch)
        {
			if (areaIdentifier == null)
            {
				if (!exactMatch && Browser.FindElementByTagName("body").Text.Contains(identifier))
                    return true;
                else
                    return false;
            }
            throw new NotImplementedException();
        }

        #endregion
    }
}
