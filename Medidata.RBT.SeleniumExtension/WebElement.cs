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
	public static class WebElement
	{
		public static RemoteWebDriver Brower(this IWebElement ele)
		{
			var driver = ((IWrapsDriver)ele).WrappedDriver as RemoteWebDriver;

			return driver;
		}

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
			IJavaScriptExecutor jsExe = driver as IJavaScriptExecutor;
			if (jsExe == null)
				throw new ArgumentException("element", "Element must wrap a web driver that supports javascript execution");

			return jsExe;
		}

		public static string GetInnerHtml(this IWebElement element)
		{
			IJavaScriptExecutor jsExe = GetJsExecutor(element);
			object obj = jsExe.ExecuteScript("return arguments[0].innerHTML", element);
			return obj as string;
		}
		 
		public static void SetInnerHtml(this IWebElement element, string html)
		{
			IJavaScriptExecutor jsExe = GetJsExecutor(element);
			jsExe.ExecuteScript("arguments[0].innerHTML = arguments[1]", element, html);
		}

		public static void SetAttribute(this IWebElement element, string attributeName, string value)
		{
			IJavaScriptExecutor jsExe = GetJsExecutor(element);
			jsExe.ExecuteScript("arguments[0].setAttribute(arguments[1], arguments[2])", element, attributeName, value);
		}

		public static void RemoveAttribute(this IWebElement element, string attributeName)
		{
			IJavaScriptExecutor	jsExe = GetJsExecutor(element);
			jsExe.ExecuteScript("arguments[0].removeAttribute(arguments[1])", element, attributeName);
		}
				
		public static void SetStyle(this IWebElement element, string style, string value)
		{
			IJavaScriptExecutor jsExe = GetJsExecutor(element);
			jsExe.ExecuteScript("arguments[0].style[arguments[1]] = arguments[2]", element, style, value);
		}

		public static string GetStyle(this IWebElement element, string style)
		{
			IJavaScriptExecutor	jsExe = GetJsExecutor(element);
			return jsExe.ExecuteScript("return arguments[0].style[arguments[1]]", element, style) as string;
		}


		public static IWebElement Parent(this IWebElement element)
		{
			return element.TryFindElementByXPath("./..");
		}

		public static IWebElement Ancestor(this IWebElement element, string tagName)
		{
			IWebElement parent = element.Parent();
			while (parent != null && parent.TagName != tagName)
			{
				parent = parent.Parent();
			}
			return parent;
		}
		
	}
}
