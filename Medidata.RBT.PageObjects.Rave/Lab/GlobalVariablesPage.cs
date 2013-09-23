using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave
{
	public class GlobalVariablesPage : LabPageBase, IVerifyObjectExistence
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

            foreach (ArchitectObjectModel variable in variables)
            {             
                Browser.TryFindElementByPartialID("_ctl0_Content_LinkButtonMainAddNew").Click();
                mainTable = Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>();

                ReadOnlyCollection<Textbox> mainDataGridTextboxes = mainTable.Rows()[mainTable.Rows().Count - 2].Textboxes();

                mainDataGridTextboxes[0].EnhanceAs<Textbox>()
                    .SetText(SeedingContext.GetExistingFeatureObjectOrMakeNew<GlobalVariable>(variable.OID, () => new GlobalVariable(variable.OID)).UniqueName);
                mainDataGridTextboxes[1].EnhanceAs<Textbox>().SetText(variable.Format);
                Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                Browser.WaitForDocumentLoad();
            }          
		}

        public bool GlobalVariablesExistWithOIDs(IEnumerable<ArchitectObjectModel> variables)
        {
            bool found = false;
            foreach (ArchitectObjectModel variable in variables)
            {
                found = false;
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text
                        .Equals(SeedingContext.GetExistingFeatureObjectOrMakeNew<GlobalVariable>(variable.OID
                        , () => { throw new Exception("GlobalVariable not seeded"); }).UniqueName))
                        found = true;
                if (!found)
                    return false;
            }
            return found;
        }

        public void GlobalVariablesDelete(IEnumerable<ArchitectObjectModel> variables)
        {
            foreach (ArchitectObjectModel variable in variables)
            {
                foreach (var row in Browser.TryFindElementById("_ctl0_Content_MainDataGrid").EnhanceAs<HtmlTable>().Rows().Skip(1))
                    if (row.Children()[0].Text.Equals(SeedingContext.GetExistingFeatureObjectOrMakeNew<GlobalVariable>(variable.OID,
                        () => { throw new Exception("GlobalVariable not seeded"); }).UniqueName))
                    {
                        row.Images().First(x => x.GetAttribute("src").EndsWith("i_cedit.gif")).Click();
                        Browser.TryFindElementBy(By.XPath(".//input[@type='checkbox']")).EnhanceAs<Checkbox>().Check();
                        Browser.ImageBySrc("../../Img/i_ccheck.gif").Click();
                        return;
                    }
            }
        }

        public void GlobalVariablesEdit(IEnumerable<ArchitectObjectModel> variables)
        {
            foreach (ArchitectObjectModel variable in variables)
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

        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            string identifier,
            bool exactMatch,
            int? amountOfTimes,
            RBT.BaseEnhancedPDF pdf = null,
            bool? bold = null,
            bool shouldExist = true)
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

        public bool VerifyObjectExistence(
            string areaIdentifier,
            string type,
            List<string> identifiers,
            bool exactMatch,
            int? amountOfTimes,
            RBT.BaseEnhancedPDF pdf,
            bool? bold,
            bool shouldExist = true)
        {
            foreach (string identifier in identifiers)
                if (VerifyObjectExistence(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }
    }
}
