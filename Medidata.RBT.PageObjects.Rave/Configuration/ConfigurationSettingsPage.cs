using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.Configuration.Models;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
	public class ConfigurationSettingsPage : ConfigurationBasePage
	{
		public bool VerifyRowWithValuesExists(IEnumerable<ConfigurationSettingsModel> createSet)
		{
			bool bOk = true;
			var configurationSettingsModel = createSet as List<ConfigurationSettingsModel> ?? createSet.ToList();

			//FindTable
			IWebElement edcConfigSettingsTable = TestContext.Browser.TryFindElementByPartialID("tblOuter");
			foreach (ConfigurationSettingsModel csm in createSet)
			{
				IWebElement edcConfigSettingsRow = edcConfigSettingsTable.TryFindElementBySpanLinktext(csm.Parameter).Parent().Parent();
				ReadOnlyCollection<Checkbox> checkBoxs = edcConfigSettingsRow.Checkboxes();
				bool checkBoxValue = bool.Parse(csm.Checkbox);
				if (checkBoxs.Count > 0)
				{
					bOk &= (checkBoxValue == checkBoxs[0].Selected);
				}

				if (checkBoxs.Count > 1)
				{
					bool checkBoxInputValue = bool.Parse(csm.Value);
					bOk &= (checkBoxInputValue == checkBoxs[1].Selected);
				}

				ReadOnlyCollection<RadioButton> radioButtons = edcConfigSettingsRow.RadioButtons();
				if (radioButtons.Count > 0)
				{
					//identify the radio button and select it
				}

				ReadOnlyCollection<Textbox> textBoxes = edcConfigSettingsRow.Textboxes();
				if (textBoxes.Count == 1)
				{
					bOk &= textBoxes[0].Value.Equals(csm.Value);
				}
			}
			return bOk;
		}


		public void FillData(IEnumerable<ConfigurationSettingsModel> createSet)
		{
			var configurationSettingsModel = createSet as List<ConfigurationSettingsModel> ?? createSet.ToList();
			
			//FindTable
			IWebElement edcConfigSettingsTable = TestContext.Browser.TryFindElementByPartialID("tblOuter");
			foreach(ConfigurationSettingsModel csm in createSet)
			{
				IWebElement edcConfigSettingsRow = edcConfigSettingsTable.TryFindElementBySpanLinktext(csm.Parameter).Parent().Parent();
				edcConfigSettingsRow = edcConfigSettingsRow.Parent();
				ReadOnlyCollection<Checkbox> checkBoxs = edcConfigSettingsRow.Checkboxes();
				bool checkBoxValue = bool.Parse(csm.Checkbox);
				if (checkBoxs.Count > 0)
				{
					if (csm.Checkbox.Equals("True"))
					{
						checkBoxs[0].Check();
					}
					else
					{
						checkBoxs[0].Uncheck();
					}
				}

				if(checkBoxs.Count>1 && (csm.Value.Equals("True") || csm.Value.Equals("False")))
				{
					if (csm.Checkbox.Equals("True"))
					{
						checkBoxs[1].Check();
					}
					else
					{
						checkBoxs[1].Uncheck();
					}
				}

				ReadOnlyCollection<RadioButton> radioButtons = edcConfigSettingsRow.RadioButtons();
				if(radioButtons.Count>0)
				{
					//identify the radio button and select it
				}

				ReadOnlyCollection<Textbox> textBoxes = edcConfigSettingsRow.Textboxes();
				if (textBoxes.Count == 1)
				{
					textBoxes[0].SetText(csm.Value);
				}
			}

		}

		public IPage Save()
		{
			return this.ClickLink("Update");
		}

		public override string URL
		{
			get
			{
				return "Modules/Configuration/Settings.aspx";
			}
		}
	}
}
