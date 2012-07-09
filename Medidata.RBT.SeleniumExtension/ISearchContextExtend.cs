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
		private static T SelectExtendElement<T>(ISearchContext context,string tag, string partialID, bool nullable)
			where T : EnhancedElement, new()
		{
			var ele = context.TryFindElementBy(By.XPath(".//"+tag+"[contains(@id,'" + partialID + "')]"));
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

		public static ReadOnlyCollection<HtmlTable> Tables(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//table" : "./table";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<HtmlTable>();
		}

		public static ReadOnlyCollection<HtmlTable> Tables(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<HtmlTable>();
		}

		public static HtmlTable Table(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElement<HtmlTable>(context,"table", partialID, nullable);
		}

		#endregion

		#region Textbox

		public static Textbox Textbox(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElement<Textbox>(context,"input", partialID, nullable);
		}

		public static ReadOnlyCollection<Textbox> Textboxes(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//input[@type='text']" : "./input[@type='text']";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Textbox>();
		}

		public static ReadOnlyCollection<Textbox> Textboxes(this ISearchContext context,string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Textbox>();
		}

		#endregion

		#region Checkbox


		public static Checkbox Checkbox(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElement<Checkbox>(context,"input", partialID, nullable);
		}


		public static ReadOnlyCollection<Checkbox> Checkboxes(this ISearchContext context, bool allLevel = true)
        {
			string xpath = allLevel ? ".//input[@type='checkbox']" : "./input[@type='checkbox']";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
        }

		public static ReadOnlyCollection<Checkbox> Checkboxes(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		#endregion

		#region Dropdown


		public static Dropdown Dropdown(this ISearchContext context, string partialID, bool nullable=false)
		{
			return SelectExtendElement<Dropdown>(context,"select", partialID, nullable);
		}


		public static ReadOnlyCollection<Dropdown> Dropdowns(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//select" : "./select";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Dropdown>();
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


		public static ReadOnlyCollection<Hyperlink> Links(this ISearchContext context, bool allLevel= true)
		{
			string xpath = allLevel ? ".//a" : "./a";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Hyperlink>();
		}

		

		#endregion

        #region HiddenInput
        
        public static ReadOnlyCollection<EnhancedElement> HiddenInputs(this ISearchContext context)
        {
            return context.FindElements(By.XPath(".//input[@type='hidden']")).CastReadOnlyCollection<EnhancedElement>();
        }

        #endregion

		#region Img


		public static Checkbox Image(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElement<Checkbox>(context, "img", partialID, nullable);
		}


		public static ReadOnlyCollection<Checkbox> Images(this ISearchContext context, bool allLevel =true)
		{
			string xpath = allLevel ? ".//img" : "./img";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		public static ReadOnlyCollection<Checkbox> Images(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		#endregion

		#region Div


		public static Checkbox Div(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElement<Checkbox>(context, "div", partialID, nullable);
		}


		public static ReadOnlyCollection<Checkbox> Divs(this ISearchContext context, bool allLevel = true)
		{
			string xpath = allLevel ? ".//div" : "./div";
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		public static ReadOnlyCollection<Checkbox> Divs(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		#endregion

		#region Span


		public static Checkbox Span(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElement<Checkbox>(context, "span", partialID, nullable);
		}


		public static ReadOnlyCollection<Checkbox> Spans(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//span")).CastReadOnlyCollection<Checkbox>();
		}

		public static ReadOnlyCollection<Checkbox> Spans(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<Checkbox>();
		}

		#endregion


		public static ReadOnlyCollection<IWebElement> Children(this ISearchContext context)
		{
			return context.FindElements(By.XPath("./*"));
		}


		#region RadioButton


		public static RadioButton RadioButton(this ISearchContext context, string partialID, bool nullable = false)
		{
			return SelectExtendElement<RadioButton>(context, "input", partialID, nullable);
		}


		public static ReadOnlyCollection<RadioButton> RadioButtons(this ISearchContext context)
		{
			return context.FindElements(By.XPath(".//input")).CastReadOnlyCollection<RadioButton>();
		}

		public static ReadOnlyCollection<RadioButton> RadioButtons(this ISearchContext context, string xpath)
		{
			return context.FindElements(By.XPath(xpath)).CastReadOnlyCollection<RadioButton>();
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


		#region TryFind

		public static T TryFindElementByPartialID<T>(this ISearchContext context, string partialID, string tag=null)
			where T : EnhancedElement, new()
		{
			return SelectExtendElement<T>(context, tag, partialID, true);
		}
		public static IWebElement TryFindElementByPartialID(this ISearchContext context, string partialID)
		{
			var ele = context.TryFindElementBy(By.XPath(".//*[contains(@id,'" + partialID + "')]"));
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
