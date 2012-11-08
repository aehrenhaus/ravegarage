using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;

using System.Collections.Specialized;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class RavePageBase : PageBase
	{
		public override IPage NavigateTo(string name)
		{
			if (new string[] {
				"Architect",
				"User Administration",
				"Site Administration",
				"Reporter",
				"Configuration",
				"Report Administration",
				"Lab Administration",
				"EED",
				"Translation Workbench","PDF Generator","DCF","Query Management","Welcome Message"}.Contains(name))
			{
				if (!(TestContext.CurrentPage is HomePage))
					TestContext.CurrentPage = new HomePage().NavigateToSelf();
			}

			if (name == "Home")
				return new HomePage().NavigateToSelf();

			return base.NavigateTo(name);
			
		}


		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Header")
				return Browser.Table("_ctl0_PgHeader_TabTable");
			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}

   

        public override string BaseURL
        {
            get 
            {
                return RaveConfiguration.Default.RaveURL;
            }
        }

        public IWebElement GetElementByControlTypeAndValue(ControlType controlType, string value)
        {
            if (controlType == ControlType.Button)
            {
                return TestContext.Browser.TryFindElementBy(By.XPath("//input[contains(@value, '" + value + "')]"));
            }
            else if (controlType == ControlType.Link)
            {
                return TestContext.Browser.TryFindElementBy(By.XPath("//a[text() = '" + value + "']"));
            }
            else
                return null;
        }

		public IPage GoBack()
		{
			Browser.Navigate().Back();
			return  TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

		public override IPage ClickLink(string linkText, string type = null, string areaIdentifier = null)
		{

			if (type == "Study")
			{
				Project project = TestContext.GetExistingFeatureObjectOrMakeNew(linkText, () => new Project(linkText));
				linkText = project.UniqueName;
			}

			IPage page = null;

			ISearchContext area = null;
			if (!string.IsNullOrEmpty(areaIdentifier))
			{
				area = Browser.TryFindElementById(areaIdentifier);
				if (area == null)
					area = GetElementByName(areaIdentifier);
			}
			else
			{
				area = Browser;
			}

			var link = area.TryFindElementBy(By.LinkText(linkText),false);

			if(link==null)
				link = area.TryFindElementBySpanLinktext(linkText);

			//another try, but with wait
			if (link == null)
				link = area.TryFindElementBy(By.LinkText(linkText), true);

			link.Click();
			return TestContext.POFactory.GetPageByUrl(new Uri(Browser.Url));
		}

        public virtual IEDCFieldControl FindLandscapeLogField(string fieldName, int rowIndex, ControlType controlType = ControlType.Default)
        {
            switch (controlType)
            {
                case ControlType.Default:
                    return new LandscapeLogField(this, fieldName, rowIndex);
                //case ControlType.Text:
                //case ControlType.LongText:
                //case ControlType.Datetime:
                //case ControlType.RadioButton:
                //case ControlType.RadioButtonVertical:
                //case ControlType.DropDownList:
                case ControlType.DynamicSearchList:
                    return new LandscapeLogField(this, fieldName, rowIndex, controlType);
                default:
                    throw new Exception("Not supported control type:" + controlType);
            }
        }

        public virtual string GetClassMapping(string name)
        {
            string className;
            switch (name)
            {
                case "Query Management":
                    className = "DCFQueriesPage";
                    break;
                case "PDF Generator":
                    className = "FileRequestPage";
                    break;
                case "Lab Administration":
                    className = "AnalytesPage";
                    break;
                case "Reporter":
                    className = "ReportsPage";
                    break;
                case "Site Administration":
                    className = "SiteAdministrationHomePage";
                    break;
                default:
                    className = name.Replace(" ", "") + "Page";
                    break;
            }
            return className;

        }
	}
}
