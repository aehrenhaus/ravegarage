using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.ConfigurationHandlers;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ScriptUtilityManagerPage : CrystalReportPage
    {
        public ScriptUtilityManagerPage() { }
        
        public override string URL
        {
            get { return "Modules/ScriptUtility/ScriptUtilityInstaller.aspx"; }
        }

        public void InstallUtilityScript(string scriptfile)
        {
            ScriptUtility su = SeedingContext.GetExistingFeatureObjectOrMakeNew(scriptfile, () => new ScriptUtility(scriptfile));
            scriptfile = RBTConfiguration.Default.UploadPath + @"\Reports\" + su.UniqueName;
            SearchContext.TryFindElementBy(By.Name("_ctl0:Content:_ctl7")).SendKeys(scriptfile);
            ClickButton("Upload");
        }
    }
}
