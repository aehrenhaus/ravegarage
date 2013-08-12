using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using System.Text.RegularExpressions;
using System.Collections.Specialized;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.ConfigurationHandlers;


namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class RavePageBase : PageBase
	{
		private static readonly IList<string> MODULE_LIST = new List<string>() { 
			"Architect",
			"User Administration",
			"Site Administration",
			"Reporter",
			"Configuration",
			"Report Administration",
			"Lab Administration",
			"EED",
			"Translation Workbench",
			"PDF Generator",
			"DCF",
			"Query Management",
			"Welcome Message"};


		public RavePageBase()
		{
		}

		public RavePageBase(WebTestContext context)
			: base(context)
		{
		}

		public override IPage NavigateTo(string name)
		{
			if (MODULE_LIST.Contains(name))
			{
				if (!(Context.CurrentPage is HomePage))
					Context.CurrentPage = new HomePage().NavigateToSelf();
			}

			if (name == "Home")
				return new HomePage().NavigateToSelf();

			return base.NavigateTo(name);
			
		}


		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Header")
				return SearchContext.Table("_ctl0_PgHeader_TabTable");
			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}

   

        public override string BaseURL
        {
            get 
            {
                return RaveConfigurationGroup.Default.RaveURL;
            }
        }

        public IWebElement GetElementByControlTypeAndValue(ControlType controlType, string value)
        {
            if (controlType == ControlType.Button)
            {
				return SearchContext.TryFindElementBy(By.XPath("//input[contains(@value, '" + value + "')]"));
            }
            else if (controlType == ControlType.Link)
            {
				return SearchContext.TryFindElementBy(By.XPath("//a[text() = '" + value + "']"));
            }
            else
                return null;
        }

		public IPage GoBack()
		{
			Browser.Navigate().Back();
			return  Context.POFactory.GetPageByUrl(new Uri(Browser.Url));
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

        /// <summary>
        /// Replace a seedable object's feature name with its unique name
        /// </summary>
        /// <param name="type">The type of the object (eg. Project, User, etc.)</param>
        /// <param name="name">The feature name of the object</param>
        /// <returns>The unique name of the seedable object</returns>
		public static string ReplaceSeedableObjectName(string type, string name)
		{
			if (type != null) type = type.Replace(" ", "");
			if (string.Equals(type,"Study", StringComparison.InvariantCultureIgnoreCase))
			{
				Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () => new Project(name));
				name = project.UniqueName;
			}
			else if (string.Equals(type, "Site", StringComparison.InvariantCultureIgnoreCase))
			{
				Site site = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () => new Site(name));
				name = site.UniqueName;
			}
			else if (string.Equals(type, "Role", StringComparison.InvariantCultureIgnoreCase))
			{
				Role role = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () => new Role(name));
				name = role.UniqueName;
			}
			else if (string.Equals(type, "User", StringComparison.InvariantCultureIgnoreCase))
			{
				User user = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () => new User(name));
				name = user.UniqueName;
			}
			else if (string.Equals(type, "Project", StringComparison.InvariantCultureIgnoreCase))
			{
				Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () => new Project(name));
				name = project.UniqueName;
			}
			else if (type == "Lab")
			{
				SharedRaveObjects.Lab lab = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () =>new SharedRaveObjects.Lab(name));
				name = lab.UniqueName;
			}
            else if (string.Equals(type, "Proposal", StringComparison.InvariantCultureIgnoreCase))
            {
                Proposal proposal = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () => new Proposal(name));
                name = proposal.UniqueName;
            }
			else if (type != null && type.ToUpper().Contains("CRF"))
            {
                CrfVersion crf = SeedingContext.GetExistingFeatureObjectOrMakeNew<CrfVersion>(name, () => null);
				if(crf!=null)
					name = crf.UniqueName;
            }
			return name;
		}

		/// <summary>
		/// returns study name, used in dropdowns.
		/// </summary>
		/// <param name="name"></param>
		/// <returns></returns>
		private string GetSeededProjectName(string name)
		{
			Project projectObject = SeedingContext.GetExistingFeatureObjectOrMakeNew(name, () => new Project(name));
			return projectObject.UniqueName;
		}
		public override IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null, bool partial = false)
		{
			//move D's code from EDC steps.ISelectLink____In____() to here
            if (areaIdentifier != null && (areaIdentifier.ToLower().Contains("project") 
                || linkText.ToLower().Contains("project") || linkText.ToLower().Contains("study")))
				linkText = SpecialStringHelper.Replace(GetSeededProjectName(linkText));
			else
				linkText = SpecialStringHelper.Replace(linkText);


			linkText = ReplaceSeedableObjectName(objectType, linkText);
			ISearchContext context = string.IsNullOrEmpty(areaIdentifier) ? SearchContext : this.GetElementByName(areaIdentifier, null);
			IWebElement link = null;
			if(linkText.Contains("•"))
                link = ISearchContextExtend.FindLinkWithBulletPoint(context, linkText);
			else
			{
                link = partial ?
                context.TryFindElementBy(By.XPath(".//a[contains(text(),'" + linkText + "')] | .//span[contains(text(),'" + linkText + "')]"))
                : context.TryFindElementBy(By.XPath(".//a[text()='" + linkText + "'] | .//span[text()='" + linkText + "']"));
			}

			if (link == null)
                throw new Exception("Link not found!");

            //We need to try to set focus to this element because in some cases 
            //the element is not in the view port and thus cannot be interacted with
            this.SetFocusElement(link);
			link.Click();


			return WaitForPageLoads();
		}

		/// <summary>
		/// Should call WebTestContext.WaitForPageLoads() directly instead of this
		/// </summary>
		/// <returns></returns>
		[Obsolete]
		protected IPage GetPageByCurrentUrlIfNoAlert()
		{
			return this.WaitForPageLoads();
		}

        /// <summary>
        /// This method can be used to modify the Url of current page followed by setting the 
        /// new Url on Browser
        /// </summary>
        /// <param name="page"></param>
        /// <param name="queryNames"></param>
        public void ModifyUrl(string page, IEnumerable<string> queryNames)
        {
            string newUrl = Browser.Url;

            //if new page is specified replace the existing page with the new page
            if (!string.IsNullOrWhiteSpace(page))
                newUrl = Regex.Replace(newUrl, @"/{1}([^/\?""]*\.aspx)", string.Format("/{0}", page));

            //if any query is specified then append this new query to the exist query string of the Url
            if (queryNames.Count() > 0)
            {
                StringBuilder sb = new StringBuilder(newUrl);

                foreach (string queryName in queryNames)
                {
                    if (!string.IsNullOrWhiteSpace(queryName))
                    {
                        sb.Append(string.Format("&{0}={1}", 
                            queryName, Context.Storage[queryName]) as string);
                    }
                }

                newUrl = sb.ToString();
            }

            Browser.Url = newUrl;
        }

        /// <summary>
        /// save the query string's field value pair from the Url based on query name specified
        /// to the WebTestContext's Storage hashtable
        /// </summary>
        /// <param name="queryName"></param>
        public void StoreQueryString(string queryName)
        {
            Dictionary<string, string> queryStringFieldValuePair = this.GetUrlQueryStringFieldValuePair();

            KeyValuePair<string, string> fieldValuePair = queryStringFieldValuePair.FirstOrDefault((p) => p.Key.Equals(queryName));

            if (!fieldValuePair.Equals(default(KeyValuePair<string, string>)))
            {
                Context.Storage[fieldValuePair.Key] = fieldValuePair.Value;
            }
            else
                throw new InvalidOperationException(
                    string.Format("Specified query string field name [{0}] does not exist in the current Url", queryName));
        }

	}
}
