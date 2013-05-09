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

        public void SetGlobalFormEntryRestriction(string formName, string role, bool add)
        {
            ChooseFromDropdown("_ctl0_Content_FormDDL", formName);
            SetGlobalEntryRoleRestrictionToForm(role, add);
        }

        public void SetGlobalFormViewRestriction(string formName, string role, bool add)
        {
            ChooseFromDropdown("_ctl0_Content_FormDDL", formName);
            SetGlobalViewRoleRestrictionToForm(role, add);
        }

        public void SetFormEntryRestriction(string formName, string role, bool selected)
        {
            ChooseFromDropdown("_ctl0_Content_FormDDL", formName);
            SetEntryRoleRestrictionToForm(role, selected);
        }

        public void SetFormViewRestriction(string formName, string role, bool selected)
        {
            ChooseFromDropdown("_ctl0_Content_FormDDL", formName);
            SetViewRoleRestrictionToForm(role, selected);
        }

        public void SetFieldEntryRestriction(string formName, string fieldName, string role, bool selected)
        {
            ChooseFromDropdown("_ctl0_Content_FormDDL", formName);
            SetEntryRoleRestrictionToField(fieldName, role, selected);        
        }

        public void SetFieldViewRestriction(string formName, string fieldName, string role, bool selected)
        {
            ChooseFromDropdown("_ctl0_Content_FormDDL", formName);
            SetViewRoleRestrictionToField(fieldName, role, selected);        
        }

        public void SetEntryRoleRestrictionToField(string fieldName, string role, bool selected)
        {
            List<IWebElement> tableRows = Browser.FindElements(
                By.XPath("*//table[@id = '_ctl0_Content_Grid']//tr[@class='evenRow' or @class='oddRow']")).ToList();


            for (int i = 0; i < tableRows.Count; i++)
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
                  
                    IWebElement roleCheckbox = tr.FindElement(
                        By.XPath("td/table[@id = '_ctl0_Content_Grid__ctl" + (i + 2) + "_Re']/tbody/tr/td/label[text() = '" + role + "']/../input"));
                    if (selected)
                        roleCheckbox.EnhanceAs<Checkbox>().Check();
                    else
                        roleCheckbox.EnhanceAs<Checkbox>().Uncheck();
                    tr.TryFindElementBy(By.XPath("td[position()=7]/a")).Click();
                    break;
                }
            }
        }


        public void SetViewRoleRestrictionToField(string fieldName, string role, bool selected)
        {
            List<IWebElement> tableRows = Browser.FindElements(
                By.XPath("*//table[@id = '_ctl0_Content_Grid']//tr[@class='evenRow' or @class='oddRow']")).ToList();


            for (int i = 0; i < tableRows.Count; i++)
            {
                IWebElement tr = tableRows[i];
                IWebElement firstCell = tr.TryFindElementBy(By.XPath("td[position() = 1]"));
                if (firstCell.Text == fieldName)
                {
                    IWebElement editButton = tr.TryFindElementBy(By.XPath("td[position() = 7]//img")); ;
                    editButton.Click();
                    //Click checkbox next to role
                    //Refresh tr after the new tables are added
                    int positionIndex = i + 2;
                    tr = Browser.TryFindElementBy(
                        By.XPath("*//table[@id = '_ctl0_Content_Grid']//tr[position() = '" + positionIndex + "']"));
                   
                    IWebElement roleCheckbox = tr.FindElement(
                        By.XPath("td/table[@id = '_ctl0_Content_Grid__ctl" + (i + 2) + "_Rv']/tbody/tr/td/label[text() = '" + role + "']/../input"));
                    if (selected)
                        roleCheckbox.EnhanceAs<Checkbox>().Check();
                    else
                        roleCheckbox.EnhanceAs<Checkbox>().Uncheck();
                    tr.TryFindElementBy(By.XPath("td[position()=7]/a")).Click();
                    break;
                }
            }
        }

        
        public void SetEntryRoleRestrictionToForm(string role, bool selected)
        {

            Checkbox roleCheckbox = new Checkbox() ;
            var table = Browser.FindElement(By.XPath("//table[@id = '_ctl0_Content_Entries']")).Children()[0];
            foreach (var tableRow in table.Children())
            {
                if (tableRow.Children()[0].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[0].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[1].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[1].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }
            }

            if (selected)
                roleCheckbox.EnhanceAs<Checkbox>().Check();
            else
                roleCheckbox.EnhanceAs<Checkbox>().Uncheck();

            Browser.Keyboard.PressKey("\n");
        }


        public void SetViewRoleRestrictionToForm(string role, bool selected)
        {
            Browser.FindElementById("_ctl0_Content_EditImgLnk").Click();

            Checkbox roleCheckbox = new Checkbox() ;
            var table = Browser.FindElement(By.XPath("//table[@id = '_ctl0_Content_Views']")).Children()[0];
            foreach (var tableRow in table.Children())
            {
                if (tableRow.Children()[0].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[0].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[1].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[1].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }
            }

            if (selected)
                roleCheckbox.EnhanceAs<Checkbox>().Check();
            else
                roleCheckbox.EnhanceAs<Checkbox>().Uncheck();

            Browser.Keyboard.PressKey("\n");
        }


        public void SetGlobalEntryRoleRestrictionToForm(string role, bool add)
        {
            Checkbox roleCheckbox = new Checkbox();
            var table = Browser.FindElement(By.XPath("//table[@id = '_ctl0_Content_GlEntries']")).Children()[0];
            foreach (var tableRow in table.Children())
            {
                if (tableRow.Children()[0].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[0].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[1].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[1].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }
            }

            roleCheckbox.EnhanceAs<Checkbox>().Check();

            if (add)
                Browser.FindElementByLinkText("Add To All Fields").Click();
            else
                Browser.FindElementByLinkText("Remove From All Fields").Click();

        }


        public void SetGlobalViewRoleRestrictionToForm(string role, bool add)
        {
            Checkbox roleCheckbox = new Checkbox();
            var table = Browser.FindElement(By.XPath("//table[@id = '_ctl0_Content_GlViews']")).Children()[0];
            foreach (var tableRow in table.Children())
            {
                if (tableRow.Children()[0].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[0].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }

                else if (tableRow.Children()[1].Children()[1].Text.Equals(role))
                {
                    roleCheckbox = tableRow.Children()[1].Children()[0].EnhanceAs<Checkbox>();
                    break;
                }
            }

            roleCheckbox.EnhanceAs<Checkbox>().Check();

            if (add)
                Browser.FindElementByLinkText("Add To All Fields").Click();
            else
                Browser.FindElementByLinkText("Remove From All Fields").Click();
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
