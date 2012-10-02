using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
    public class LabUnitDictionariesPage : LabPageBase, ICanVerifyExist
    {
        

        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/LabUnitDictionary.aspx";
            }
        }

        public void IAddNewLabUnitDictionaries(IEnumerable<ArchitectObjectModel> dictionaries)
		{
            HtmlTable mainTable;

            foreach (var dictionary in dictionaries)
            {
                ClickLink("Add Lab Unit Dictionary");
                mainTable = Browser.TryFindElementById("_ctl0_Content_LabUnitDictionaryGrid").EnhanceAs<HtmlTable>();
                mainTable.Rows()[mainTable.Rows().Count - 2].Textboxes()[0].EnhanceAs<Textbox>().SetText(dictionary.Name);
                Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
            }          
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
                        Browser.Checkboxes()[0].Click();  
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

        public bool VerifyTableRowsExist(string tableIdentifier, Table matchTable)
        {
            throw new NotImplementedException();
        }

        public bool VerifyControlExist(string identifier)
        {
            throw new NotImplementedException();
        }

        public bool VerifyTextExist(string identifier, string text)
        {
            if (identifier == null)
            {
                if (Browser.FindElementByTagName("body").Text.Contains(text))
                    return true;
                else
                    return false;
            }
            throw new NotImplementedException();
        }

        #endregion
    }
}
