using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectRestrictionsPage : ArchitectBasePage
	{
        public void SetEntryRestriction(string formName, string fieldName, string role)
        {
            ChooseFromDropdown("_ctl0_Content_FormDDL", formName);
            AddRoleRestrictionToField(fieldName, role);
        }

        public void AddRoleRestrictionToField(string fieldName, string role)
        {
            List<IWebElement> tableRows = Browser.FindElements(
                By.XPath("*//table[@id = '_ctl0_Content_Grid']//tr[@class='evenRow' or @class='oddRow']")).ToList();


            for (int i = 1; i < tableRows.Count; i++)
            {
                IWebElement tr = tableRows[i];
                IWebElement firstCell = tr.TryFindElementBy(By.XPath("td[position() = 1]"));
                if (firstCell.Text == fieldName)
                {
                    IWebElement editButton = tr.TryFindElementBy(By.XPath("td[position() = 7]//img"));;
                    editButton.Click();
                    //Click checkbox next to role
                    //Refresh tr after the new tables are added
                    int positionIndex = i + 2;
                    tr = Browser.TryFindElementBy(
                        By.XPath("*//table[@id = '_ctl0_Content_Grid']//tr[position() = '" + positionIndex + "']"));
                    //IWebElement entryRestrictionBox = tr.FindElement(By.XPath("//table[@id = '_ctl0_Content_Grid__ctl17_Re']"));
                    //IWebElement roleLabel = entryRestrictionBox.FindElement(By.XPath("//tbody//tr//td//label[text() = '" + role + "']"));
                    //IWebElement roleCheckbox = roleLabel.Parent().FindElement(By.XPath("input"));
                    IWebElement roleCheckbox = tr.FindElement(
                        By.XPath("td/table[@id = '_ctl0_Content_Grid__ctl17_Re']/tbody/tr/td/label[text() = '" + role + "']/../input"));
                    roleCheckbox.EnhanceAs<Checkbox>().Check();
                    tr.TryFindElementBy(By.XPath("td[position()=7]/a")).Click();
                    break;
                }
            }

        }

		public override string URL
		{
			get
			{
                return "Modules/Architect/Restrictions.aspx";
			}
		}
	}
}
