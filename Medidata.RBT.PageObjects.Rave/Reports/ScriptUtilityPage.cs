using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ScriptUtilityPage : CrystalReportPage
    {
        public ScriptUtilityPage()
		{
		}

        public override string URL
        {
            get
            {
                return "Modules/ScriptUtility/ScriptUtility.aspx";
            }
        }

        public override IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
        {
            Site site = SeedingContext.TryGetExistingFeatureObject<Site>(text);
            if (identifier.Equals("Source", StringComparison.InvariantCultureIgnoreCase))
                return base.ChooseFromDropdown("Source", String.Format("{0} - {1} (Prod)", site.Number, site.UniqueName), objectType, areaIdentifier);
            else if (identifier.Equals("Destination", StringComparison.InvariantCultureIgnoreCase))
                return base.ChooseFromPartialDropdown("Destination", String.Format("{0} - {1}", site.Number, site.UniqueName), objectType, areaIdentifier);

            return base.ChooseFromDropdown(identifier, text, objectType, areaIdentifier);
        }

        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
             if (identifier == "Source")
               return base.Browser.TryFindElementByName("_ctl0:Content:VSWO1:Prev_Run_0:_ctl4");
             else if (identifier == "Destination")
               return base.Browser.TryFindElementByName("_ctl0:Content:VSWO1:Prev_Run_0:NonDParams:_ctl3");
             return base.GetElementByName(identifier, areaIdentifier, listItem);
        } 

        public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
        {
            IPage result = null;

            if ("Live Update".Equals(identifier))
                result = base.ChooseFromCheckboxes("LiveStatusUpdate", isChecked);

            return result;
        }
    }
}
