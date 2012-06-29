using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Internal;

namespace Medidata.RBT.SeleniumExtension
{
	public static class ISearchContextExtend
	{
		private static T SelectExtendElement<T>(ISearchContext context, string partialID, bool nullable) where T : EnhancedElement, new()
		{
			var ele = context.TryFindElementBy(By.XPath(".//*[contains(@id,'" + partialID + "')]"));
			if (ele == null)
			{
				if (nullable)
					return null;
				else
					throw new Exception("Can't find element by partialID:" + partialID);
			}
			return ele.EnhanceAs<T>();
		}
		
		private static ReadOnlyCollection<T> CastReadOnlyCollection<T>(this ReadOnlyCollection<IWebElement> coll)
			where T : EnhancedElement, new()
		{
			return new ReadOnlyCollection<T>(coll.Select(x => x.EnhanceAs<T>()).ToList());
		}
  

		#region Table

		public static ReadOnlyCollection<HtmlTable> Tables(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//table")).CastReadOnlyCollection<HtmlTable>();
		}

		public static ReadOnlyCollection<HtmlTable> Tables(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<HtmlTable>();
		}

		public static HtmlTable Table(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElement<HtmlTable>(context, partialID, nullable);
		}

		#endregion


		#region Textbox

		public static Textbox Textbox(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElement<Textbox>(context, partialID, nullable);
		}

		public static ReadOnlyCollection<Textbox> Textboxes(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//input[@type='text']")).CastReadOnlyCollection<Textbox>();
		}

		public static ReadOnlyCollection<Textbox> Textboxes(this ISearchContext context,string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Textbox>();
		}

		#endregion


		#region Checkbox


		public static Checkbox Checkbox(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElement<Checkbox>(context, partialID, nullable);
		}


		public static ReadOnlyCollection<Checkbox> Checkboxes(this ISearchContext context)
        {
			return context.FindElements(By.XPath(".//input[@type='checkbox']")).CastReadOnlyCollection<Checkbox>();
        }

		public static ReadOnlyCollection<Checkbox> Checkboxes(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		#endregion

		#region Dropdown


		public static Dropdown Dropdown(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElement<Dropdown>(context, partialID, nullable);
		}


		public static ReadOnlyCollection<Dropdown> Dropdowns(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//select")).CastReadOnlyCollection<Dropdown>();
		}

		public static ReadOnlyCollection<Dropdown> Dropdowns(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Dropdown>();
		}

		#endregion

		#region Hyperlink

		public static Hyperlink Link(this ISearchContext context, string linktext)
		{
			var ele = context.TryFindElementBy(By.LinkText(linktext));
			if (ele == null)
				throw new Exception("Can't find hyperlink by text:" + linktext);
			return ele.EnhanceAs<Hyperlink>();
		}


		public static ReadOnlyCollection<Hyperlink> Links(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//a")).CastReadOnlyCollection<Hyperlink>();
		}

		

		#endregion

        #region HiddenInput
        
        public static ReadOnlyCollection<EnhancedElement> HiddenInputs(this ISearchContext context)
        {
            return context.FindElements(By.XPath(".//input[@type='hidden']")).CastReadOnlyCollection<EnhancedElement>();
        }

        #endregion

        public static ReadOnlyCollection<EnhancedElement> FindElementsByPartialId(this ISearchContext context, string partialID)
        {
            return context.FindElements(By.XPath(".//*[contains(@id,'" + partialID + "')]")).CastReadOnlyCollection<EnhancedElement>();
        }


		public static ReadOnlyCollection<EnhancedElement> FindImagebuttons(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//input[@type='image']")).CastReadOnlyCollection < EnhancedElement>();
		}

		public static ReadOnlyCollection<EnhancedElement> FindImages(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//img")).CastReadOnlyCollection < EnhancedElement>();
		}

		public static ReadOnlyCollection<EnhancedElement> FindSpans(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//span")).CastReadOnlyCollection < EnhancedElement>();
		}

		public static ReadOnlyCollection<EnhancedElement> FindDivs(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//div")).CastReadOnlyCollection < EnhancedElement>();
		}

		#region TryFind

		public static IWebElement TryFindElementByPartialID(this ISearchContext context, string partialID)
		{
			IWebElement ele = null;
			try
			{
				ele = context.FindElement(By.XPath(".//*[contains(@id,'"+partialID+"')]"));
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementBy(this ISearchContext context,  By by)
		{
			IWebElement ele = null;
			try
			{
				ele = context.FindElement(by);
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementById(this RemoteWebDriver context, string Id)
		{
			IWebElement ele = null;
			try
			{
				ele = context.FindElementById(Id);
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementByName(this RemoteWebDriver context, string name)
		{
			IWebElement ele = null;
			try
			{
				ele = context.FindElementByName(name);
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementByLinkText(this RemoteWebDriver context, string LinkText)
		{
			IWebElement ele = null;
			try
			{
	
				ele = context.FindElementByLinkText(LinkText);
			}
			catch
			{
			}
			return ele;
		}

		#endregion

	}
}
