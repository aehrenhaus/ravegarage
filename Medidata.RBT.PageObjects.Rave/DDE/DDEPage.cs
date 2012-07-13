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


        protected override IWebElement GetElementByName(string name)
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

            IWebElement ele = Browser.TryFindElementById(mapping[name]);
            if (ele==null)
            {
                throw new Exception("Can't find element: "+name);
            }

            return ele;
        }

        public override IPage Type(string name, string text)
        {
            text = SpecialStringHelper.Replace(text);

            IWebElement field = GetElementByName(name);
			var input = field.TryFindElementBy(By.XPath("./span/input[position()=1]")).EnhanceAs<Textbox>();
            input.SetText(text);
            return this;
        }

        public override IPage ChooseFromDropdown(string name, string text)
        {
			//first type ,then choose will limite the count of options.
			Type(name, text);

            IWebElement field = GetElementByName(name);

			//IF type first, then do not need to click the dropdown button.
			//IF click, what you entered will not be the filter
            //IWebElement dropdownButton = field.TryFindElementBy(By.XPath("./span/input[position()=2]"));
            //dropdownButton.Click();

			var option = this.WaitForElement(
				driver => field.FindElements(By.XPath("./div[position()=2]/div")).FirstOrDefault(x => x.Text == text),
				name + " not found: " + text
				);
		
			option.Click();
            return this;
        }

		public DDEPage FillDataPoints(IEnumerable<FieldModel> fields)
		{
			foreach (var field in fields)
				FindField(field.Field).EnterData(field.Data);

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
