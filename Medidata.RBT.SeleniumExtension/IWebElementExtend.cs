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
	public static class IWebElementExtend
	{

		public static T EnhanceAs<T>(this IWebElement ele) where T : EnhancedElement, new() 
		{
			if (ele is T)
				return ele as T;

			return new T().SetComponent<T>(ele);
		}

		private static IJavaScriptExecutor GetJsExecutor(IWebElement element)
		{

			IWrapsDriver wrappedElement = element as IWrapsDriver;
			if (wrappedElement == null)
				throw new ArgumentException("element", "Element must wrap a web driver");

			IWebDriver driver = wrappedElement.WrappedDriver;
			IJavaScriptExecutor javascript = driver as IJavaScriptExecutor;
			if (javascript == null)
				throw new ArgumentException("element", "Element must wrap a web driver that supports javascript execution");

			return javascript;
		}

		public static void  SetAttribute(this IWebElement element, string attributeName, string value)
		{
			GetJsExecutor(element).ExecuteScript("arguments[0].setAttribute(arguments[1], arguments[2])", element, attributeName, value);
		}

		public static void RemoveAttribute(this IWebElement element, string attributeName)
		{
			GetJsExecutor(element).ExecuteScript("arguments[0].removeAttribute(arguments[1])", element, attributeName);
		}


		public static IWebElement Parent(this IWebElement element)
		{
			return element.TryFindElementBy(By.XPath("./.."));
		}

		public static IWebElement Ancestor(this IWebElement element, string name)
		{
			IWebElement parent = element.Parent();
			while (parent != null && parent.TagName != name)
			{
				parent = parent.Parent();
			}
			return parent;
		}
		
	}
}
