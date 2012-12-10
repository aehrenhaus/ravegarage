﻿using System;
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
	public class GlobalVariablesPage : LabPageBase, IVerifySomethingExists
    {
        

        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/GlobalVariable.aspx";
            }
        }

        public void IAddNewGlobalVariables(IEnumerable<ArchitectObjectModel> variables)
		{
            HtmlTable mainTable;
            //Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows()[5].Textboxes()[0]


            foreach (var variable in variables)
            {             
                Browser.TryFindElementByPartialID("_ctl0_Content_LinkButtonMainAddNew").Click();
                mainTable = Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>();
                mainTable.Rows()[mainTable.Rows().Count - 2].Textboxes()[0].EnhanceAs<Textbox>().SetText(variable.OID);
                mainTable.Rows()[mainTable.Rows().Count - 2].Textboxes()[1].EnhanceAs<Textbox>().SetText(variable.Format);
                Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                Browser.WaitForDocumentLoad();
            }          
		}
        public bool GlobalVariablesExistWithOIDs(IEnumerable<ArchitectObjectModel> variables)
        {
            bool found = false;
            foreach (var variable in variables)
            {
                found = false;
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(variable.OID))
                        found = true;
                if (!found)
                    return false;
            }
            return found;
        }
        public void GlobalVariablesDelete(IEnumerable<ArchitectObjectModel> variables)
        {
            foreach (var variable in variables)
            {
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(variable.OID))
                    {
                        row.Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();
                        Browser.TryFindElementBy(By.XPath(".//input[@type='checkbox']")).Click();
                        Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                        return;
                    }
            }
        }
        public void GlobalVariablesEdit(IEnumerable<ArchitectObjectModel> variables)
        {
            foreach (var variable in variables)
            {
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(variable.From))
                    {
                        row.Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();
                        Browser.TryFindElementByPartialID("_ctl0_Content_MainDataGrid__ct").EnhanceAs<Textbox>().SetText(variable.To);
                        Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                        return;
                    }
            }
        }

   
		bool IVerifySomethingExists.VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch)
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

    }
}
