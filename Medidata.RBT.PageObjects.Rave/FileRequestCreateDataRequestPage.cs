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
	public class FileRequestCreateDataRequestPage : RavePageBase
	{
		public FileRequestPage CreateDataPDF(Table table)
		{

			var row1 = table.Rows[0];
			foreach (var header in table.Header)
			{
				var val = row1[header];
				switch (header)
				{
					case "Name":
						Type("Name", val);
						break;
					case "Profile":
						ChooseFromDropdown("_ctl0_Content_FileRequestForm_ConfigProfileID", val);
						break;
					case "Study":
						ChooseFromDropdown("Study", val);
						break;
					case "Role":
						WaitForElement("Role",x => x.GetAttribute("disabled") == "false");
						ChooseFromDropdown("Role", val);
						break;
					case "SiteGroup":


						break;
					case "Site":
						var expandSite = Browser.FindElementById("ISitesSitegroups_SG_1");
						expandSite.Click();
						
				
						var div = Browser.TryFindElementById("DSitesSitegroups_SG_1");
						var span = WaitForElement(b => div.FindSpans().FirstOrDefault(x => x.Text == val));
						span.Checkboxes()[0].Click();

						break;
					case "Subject":
						var expandBtn = Browser.FindElementById("Subjects_ShowHideBtn");
						expandBtn.Click();
				
						var tr = WaitForElement(b=>b.FindElements(By.XPath("//table[@id='Subjects_FrontEndCBList']/tbody/tr")).FirstOrDefault(x=>x.Text==val));

						tr.Checkboxes()[0].Click();
						break;

				}
			}

			ClickLink("Save");
			return new FileRequestPage() ;
		}
	}
}
