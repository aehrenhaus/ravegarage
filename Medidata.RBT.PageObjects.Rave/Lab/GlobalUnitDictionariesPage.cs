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
    public class GlobalUnitDictionariesPage : LabPageBase
    {
        

        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/GlobalUnitDictionary.aspx";
            }
        }

        public void IAddNewGlobalUnitDictionaries(IEnumerable<ArchitectObjectModel> dictionaries)
		{
            HtmlTable mainTable;
            //Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows()[5].Textboxes()[0]


            foreach (var dictionary in dictionaries)
            {             
                Browser.TryFindElementByPartialID("_ctl0_Content_LinkButtonMainAddNew").Click();
                mainTable = Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>();
                mainTable.Rows()[mainTable.Rows().Count - 2].Textboxes()[0].EnhanceAs<Textbox>().SetText(dictionary.Name);
                Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
            }          
		}


        public bool GlobalDictionariesExistWithNames(IEnumerable<ArchitectObjectModel> dictionaries)
        {
            bool found = false;
            foreach (var dictionary in dictionaries)
            {
                found = false;
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(dictionary.Name))
                        found = true;
                if (!found)
                    return false;
            }
            return found;
        }        
        public void GlobalDictionariesDelete(IEnumerable<ArchitectObjectModel> dictionaries)
        {
            foreach (var dictionary in dictionaries)
            {
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(dictionary.Name))
                    {
                        row.Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();
                        Browser.Checkboxes()[0].Click();  // only one checkbox, so selecting
                        Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                        return;
                    }
            }
        }
        public void GlobalDictionariesEdit(IEnumerable<ArchitectObjectModel> dictionaries)
        {
            foreach (var dictionary in dictionaries)
            {
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(dictionary.From))
                    {
                        row.Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();
                        Browser.TryFindElementByPartialID("_ctl0_Content_MainDataGrid__ct").EnhanceAs<Textbox>().SetText(dictionary.To);
                        Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                        return;
                    }
            }
        }
    }
}
