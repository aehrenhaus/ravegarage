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
    public class UnitConversionsPage : LabPageBase
    {
        

        public override string URL
        {
            get
            {
                return "Modules/LabAdmin/LabUnitConversionPage.aspx";
            }
        }

        public void AddNewConversion(UnitConversionModel unitModel)
        {
            this.ClickLink("Add New Conversion");
            this.ChooseFromDropdown("DropDownListUnitFrom", unitModel.From);
            this.ChooseFromDropdown("DropDownListUnitTo", unitModel.To);
            this.ChooseFromDropdown("DropDownListAnalyte", unitModel.Analyte);
            this.Type("ConstantA", unitModel.A);
            this.Type("ConstantB", unitModel.B);
            this.Type("ConstantC", unitModel.C);
            this.Type("ConstantK", unitModel.D);
            Browser.LinkByPartialText("Update").Click();
        }

    }
}
