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
			ModifyConversionAndUpdate(unitModel);
        }


		public void EditConversion(UnitConversionModel unitModel)
		{

			var table = Browser.TryFindElementByPartialID("UnitConversionGrid").EnhanceAs<HtmlTable>();
			var matchTable = new Table("From","To");

			matchTable.AddRow(unitModel.From,unitModel.To);

			var row = table.FindMatchRows(matchTable)[0];
			var editImage = row.ImageBySrc("../../Img/i_cedit.gif");
			editImage.Click();

			ModifyConversionAndUpdate(unitModel);
		
		}

        public void DeleteConversion(UnitConversionModel unitModel)
        {

            var table = Browser.TryFindElementByPartialID("UnitConversionGrid").EnhanceAs<HtmlTable>();
            var matchTable = new Table("From", "To");

            matchTable.AddRow(unitModel.From, unitModel.To);

            var row = table.FindMatchRows(matchTable)[0];
            var editImage = row.ImageBySrc("../../Img/i_cedit.gif");
            editImage.Click();

            row.Checkbox("chkDelete").Check();
            Browser.LinkByPartialText("Update").Click();
        }

		private void ModifyConversionAndUpdate(UnitConversionModel unitModel)
		{
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
