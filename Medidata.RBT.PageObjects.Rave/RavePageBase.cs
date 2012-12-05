using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
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

		public override IPage ChooseFromDropdown(string identifier, string text, string objectType = null, string areaIdentifier = null)
		{
            if (objectType == null && identifier.ToUpper().Contains("CRF"))
            {                
                objectType = "CRF";
                return base.ChooseFromPartialDropdown(identifier, ReplaceSeedableObjectName(objectType, text), objectType, areaIdentifier);
            }
            else
                return base.ChooseFromDropdown(identifier, ReplaceSeedableObjectName(objectType, text), objectType, areaIdentifier);
		}

		private string ReplaceSeedableObjectName(string type, string name)
		{
            try // try needed, in case name comes in as already seeded.   
            {
                if (type == "Study")
                {
                    Project project = TestContext.GetExistingFeatureObjectOrMakeNew(name, () => default(Project));
                    name = project.UniqueName;
                }
                else if (type == "Site")
                {
                    Site site = TestContext.GetExistingFeatureObjectOrMakeNew(name, () => default(Site));
                    name = site.UniqueName;
                }
                else if (type == "Role")
                {
                    Role role = TestContext.GetExistingFeatureObjectOrMakeNew(name, () => default(Role));
                    name = role.UniqueName;
                }
                else if (type == "User")
                {
                    User user = TestContext.GetExistingFeatureObjectOrMakeNew(name, () => default(User));
                    name = user.UniqueName;
                }
                else if (type == "Project")
                {
                    Project project = TestContext.GetExistingFeatureObjectOrMakeNew(name, () => default(Project));
                    name = project.UniqueName;
                }
				else if (type == "Lab")
				{
					SharedRaveObjects.Lab lab = TestContext.GetExistingFeatureObjectOrMakeNew(name, () => default(SharedRaveObjects.Lab));
					name = lab.UniqueName;
				}
				else if (type != null && type.ToUpper().Contains("CRF"))
                {
                    CrfVersion crf = TestContext.GetExistingFeatureObjectOrMakeNew(name, () => default(CrfVersion));
                    name = crf.UniqueName;
                }
            }
            catch
            {
            }
			return name;
		}

		public override IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null)
		{
			linkText = ReplaceSeedableObjectName(objectType, linkText);
            var xPathSelector = By.XPath(string.Format(".//a[text()='{0}']", linkText));


			ISearchContext area = null;
			if (!string.IsNullOrEmpty(areaIdentifier))
			{
				//area = Browser.TryFindElementById(areaIdentifier);
				//if (area == null)
					area = GetElementByName(areaIdentifier);
			}
			else
			{
				area = Browser;
			}

            IWebElement link = area.TryFindElementBy(xPathSelector, false);

            if(link == null && linkText.Contains("•"))
                link = ISearchContextExtend.FindLinkWithBulletPoint(area, linkText);

			if(link == null)
				link = area.TryFindElementBySpanLinktext(linkText);

			//another try, but with wait
            if (link == null)
                link = area.TryFindElementBy(xPathSelector, true);

            if (link == null)
                throw new Exception("Link not found!");

            //We need to try to set focus to this element because in some cases 
            //the element is not in the view port and thus cannot be interacted with
            this.SetFocusElement(link);
			link.Click();
			
            Thread.Sleep(200);
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


		/// <summary>
		/// Clicks the link that is created as a span with an onclick event.  
		/// </summary>
		/// <param name="linkText">The link text.</param>
		/// <returns></returns>
		public virtual IPage ClickSpanLink(string linkText)
		{
			IWebElement item = Browser.TryFindElementByLinkText(linkText);
			if (item != null)
				item.Click();
			else
				throw new Exception("Can't find link by text:" + linkText);

			return GetPageByCurrentUrlIfNoAlert();
		}
	}
}
