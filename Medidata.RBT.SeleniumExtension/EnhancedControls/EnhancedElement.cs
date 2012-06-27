using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using OpenQA.Selenium.Internal;

namespace Medidata.RBT.SeleniumExtension
{
	public class EnhancedElement:IWebElement
	{
		private IWebElement ele;

		public T SetComponent<T>(IWebElement ele) where T:EnhancedElement
		{

			this.ele = ele;
			return this as T;
		}

		public EnhancedElement()
		{
		}

		public EnhancedElement(IWebElement ele)
		{
			this.ele = ele;
		}



		private IJavaScriptExecutor GetJsExecutor(IWebElement element)
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

		public void SetAttribute(string attributeName, string value)
		{
			GetJsExecutor(this).ExecuteScript("arguments[0].setAttribute(arguments[1], arguments[2])", this, attributeName, value);
		}

		public void RemoveAttribute(string attributeName)
		{
			GetJsExecutor(this).ExecuteScript("arguments[0].removeAttribute(arguments[1])", this, attributeName);
		}


		#region IWebElement

		public void Clear()
		{
			ele.Clear();
		}

		public void Click()
		{
			ele.Click();
		}

		public bool Displayed
		{
			get { return ele.Displayed; }
		}

		public bool Enabled
		{
			get { return ele.Enabled; }
		}

		public string GetAttribute(string attributeName)
		{
			return ele.GetAttribute(attributeName);
		}

		public string GetCssValue(string propertyName)
		{
			return ele.GetCssValue(propertyName);
		}

		public System.Drawing.Point Location
		{
			get { return ele.Location; }
		}

		public bool Selected
		{
			get { return ele.Selected; }
		}

		public void SendKeys(string text)
		{
			ele.SendKeys(text);
		}

		public System.Drawing.Size Size
		{
			get { return ele.Size; }
		}

		public void Submit()
		{
			ele.Submit();
		}

		public string TagName
		{
			get {return ele.TagName; }
		}

		public string Text
		{
			get { return ele.Text; }
		}

		public IWebElement FindElement(By by)
		{
			return ele.FindElement(by);
		}

		public ReadOnlyCollection<IWebElement> FindElements(By by)
		{
			return ele.FindElements(by);
		}

		#endregion


	}
}
