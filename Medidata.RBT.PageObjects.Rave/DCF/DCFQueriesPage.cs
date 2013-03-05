using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;


namespace Medidata.RBT.PageObjects.Rave
{
	public class DCFQueriesPage : RavePageBase
	{
        /// <summary>
        /// returns study name, used in dropdowns.
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        private string GetSeededStudyName(string name)
        {
            string newName;
            string environment = " (Prod)";
            if (name.Contains(environment))
            {
                newName = name.Replace(environment, "");
                Project projectObject = SeedingContext.GetExistingFeatureObjectOrMakeNew(newName, () => new Project(newName));
                return projectObject.UniqueName + environment;
            }
            return name;
        }
        public override IPage ChooseFromDropdown(string name, string text, string objectType = null, string areaIdentifier = null)
        {
            if ("Study,Folder,Site Group,Form,Site,Subject".Split(',').Contains(name))
            {
                IWebElement dropdownTD = GetElementByName(name);
                CompositeDropdown dropdown = new CompositeDropdown(this, name, dropdownTD);
                if (name == "Study")
                    dropdown.TypeAndSelect(GetSeededStudyName(text));
                else
                    dropdown.TypeAndSelect(text);
            }
            else
            {
                base.ChooseFromDropdown(name, text);
            }

            return this;
        }

        /// <summary>
        /// See IPage interface
        /// </summary>
        public override IPage ClickButton(string identifier)
        {
            var element = Browser.ButtonByText(identifier, true, false);
            if (element == null)
                element = Browser.ButtonByID(identifier, true, false);


            if (element == null)
                element = GetElementByName(identifier);

            if (element == null)
                throw new Exception("Can't find button:" + identifier);
            element.Click();

            return WaitForPageLoads();
        }

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{

			if ("Study,Folder,Site Group,Form,Site,Subject".Split(',').Contains(identifier))
			{
				var table = Browser.FindElementById("Table2");

				var span = table.FindElement(By.Id("_ctl0_Content_sl"+identifier.Replace(" ","")));
				return span.Parent();
			}

			NameValueCollection mapping = new NameValueCollection();
			mapping["Marking Group"] = "_ctl0_Content_ddlMarkingGroup";
			mapping["Advanced Search"] = "_ctl0_Content_lbtnAdvSearch";
			mapping["Query Status"] = "_ctl0_Content_ddlQueryStatus";
			mapping["Search Result"] = "_ctl0_Content_grdSearchResult";
			

			IWebElement ele = Browser.TryFindElementById(mapping[identifier]);
			if (ele == null)
			{
				throw new Exception("Can't find element: " + identifier);
			}

			return ele;
		}


		public override string URL
		{
			get
			{
				return "Modules/DCF/DCFQueries.aspx";
			}
		}
	}
}
