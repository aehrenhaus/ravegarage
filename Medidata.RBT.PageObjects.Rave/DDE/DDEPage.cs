using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class DDEPage : RavePageBase
	{
		public DDEPage()
		{
		}


		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
      
            NameValueCollection mapping = new NameValueCollection();
            mapping["Study"] = "_ctl0_Content_DPL1_SLHolderStdy";
            mapping["Environment"] = "_ctl0_Content_DPL1_SLHolderEnv";
            mapping["Site"] = "_ctl0_Content_DPL1_SLHolderSite";
            mapping["Subject"] = "_ctl0_Content_DPL1_SLHolderSubj";
            mapping["Folder"] = "_ctl0_Content_DPL1_SLHolderFldr";
            mapping["Form"] = "_ctl0_Content_DPL1_SLHolderFrm";

            mapping["Folder Repeat"] = "_ctl0_Content_DPL1_SLHolderFldrRpt";
            mapping["Form Repeat"] = "_ctl0_Content_DPL1_SLHolderFrmRpt";
			mapping["Locate"] = "_ctl0_Content_DPL1_BtnLocateLbl";

            IWebElement ele = Browser.TryFindElementById(mapping[identifier]);
            if (ele==null)
            {
				return base.GetElementByName(identifier,areaIdentifier,listItem);
            }

            return ele;
        }

        public override IPage Type(string name, string text)
        {
			IWebElement dropdownTD = GetElementByName(name);
			CompositeDropdown dropdown = new CompositeDropdown(this,name, dropdownTD);
			dropdown.Type(text);
            return this;
        }

        public override IPage ChooseFromDropdown(string name, string text)
        {
            IWebElement dropdownTD = GetElementByName(name);
			CompositeDropdown dropdown = new CompositeDropdown(this,name, dropdownTD);
			dropdown.TypeAndSelect(text);
			
            return this;
        }

		public DDEPage FillDataPoints(IEnumerable<FieldModel> fields)
		{
			foreach (var field in fields)
				FindField(field.Field).EnterData(field.Data, EnumHelper.GetEnumByDescription<ControlType>(field.ControlType));

			return this;
		}

		public IEDCFieldControl FindField(string fieldName)
		{
			return new NonLabDataPageControl(this).FindField(fieldName);
		}
	

		public DDEPage FillLoglineDataPoints(int line, Table table)
		{
			IWebElement tb = Browser.TryFindElementById("log");
			var ths = tb.FindElements(By.XPath("./tbody/tr[position()=1]/td"));
			Dictionary<string, int> ordinal = new Dictionary<string, int>();
			var tds = tb.FindElements(By.XPath("./tbody/tr[position()="+(line+1)+"]/td"));
			
			for(int i =0;i<ths.Count;i++)
			{
				ordinal[ths[i].Text.Trim()] = i;
			}

			foreach (var row in table.Rows)
			{
				int index = 0;
				try
				{
					index = ordinal[row["Field"]];
				}
				catch
				{
					throw new Exception("Field " + row["Field"] + "does not exist in log form");
				}
				FillLoglineDataPoint(tds[index], row["Data"]);
			}

			return this;
		}

		private void FillLoglineDataPoint(IWebElement fieldContainer, string value)
		{
			fieldContainer.Textboxes()[0].SetText(value);
		}

		public DDEPage SaveForm()
		{
			IWebElement btn = Browser.TryFindElementById("_ctl0_Content_dde1_header_SaveLink1");
			if(btn==null)
				btn = Browser.TryFindElementById("_ctl0_Content_dde2_header_SaveLink1");

			if (btn == null)
				throw new Exception("Can not find the Save button");
			btn.Click();
			return this;
		}

		public override string URL { get { return "Modules/DDE/DdePage.aspx"; } }
	}
}
