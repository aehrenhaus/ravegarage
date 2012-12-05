using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Collections.ObjectModel;

namespace Medidata.RBT.PageObjects.Rave.Lab
{
	public class StandardGroupsPage : LabPageBase
	{
		public override string URL
		{
			get
			{
				return "Modules/LabAdmin/LabStdGroups.aspx";
			}
		}

		/// <summary>
		/// Add a standardGroup
		/// </summary>
		/// <param name="rangeTypeName">The name of the standardGroup to be added</param>
		public void AddStandardGroup(string standardGroupName)
		{
			this.ClickLink("Add New");
			ReadOnlyCollection<IWebElement> rows = Browser.TryFindElementBy(By.XPath("//table[@id = '_ctl0_Content_MainDataGrid']"))
				.EnhanceAs<HtmlTable>().Rows();

			foreach (IWebElement row in rows.Reverse<IWebElement>())
			{
				IWebElement nameInput = row.TryFindElementByPartialID("Group");
				if (nameInput != null)
				{
					nameInput.EnhanceAs<Textbox>().SetText(standardGroupName);
					IWebElement tr = nameInput.Parent().Parent();
					IWebElement acceptButton = tr.FindElements(By.XPath(".//img")).FirstOrDefault(x => x.GetAttribute("src").EndsWith("i_ccheck.gif"));
					acceptButton.Click();
					break;
				}
			}
		}
	}
}
