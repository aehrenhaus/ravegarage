using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Internal;

namespace Medidata.RBT.PageObjects
{
	public static class RemoteWebDriverExtend
	{
        public static ReadOnlyCollection<IWebElement> FindTextboxes(this ISearchContext driver)
        {
            return driver.FindElements(By.XPath(".//input[@type='text']"));
        }

		public static ReadOnlyCollection<IWebElement> FindCheckboxes(this ISearchContext driver)
        {
            return driver.FindElements(By.XPath(".//input[@type='checkbox']"));
        }

		public static ReadOnlyCollection<IWebElement> FindImagebuttons(this ISearchContext driver)
		{
			return driver.FindElements(By.XPath(".//input[@type='image']"));
		}

		public static ReadOnlyCollection<IWebElement> FindImages(this ISearchContext driver)
		{
			return driver.FindElements(By.XPath(".//img"));
		}

		public static ReadOnlyCollection<IWebElement> FindSpans(this ISearchContext driver)
		{
			return driver.FindElements(By.XPath(".//span"));
		}
		public static ReadOnlyCollection<IWebElement> FindDivs(this ISearchContext driver)
		{
			return driver.FindElements(By.XPath(".//div"));
		}

		/// <summary>
		/// This will find the html rows(tr) that match the data in the Specflow.Table
		/// 
		/// TODO:Performance issue:
		/// 
		/// If dataTable has N rows and htmlTable has M rows and dataTable has X columns
		/// this method will scann N * M * X times .
		/// BE SURE to use on small tables.
		/// </summary>
		/// <param name="dataTable"></param>
		/// <param name="htmlTable"></param>
		/// <returns></returns>
		public static ReadOnlyCollection<IWebElement> FindMatchTrs(this IWebElement htmlTable, Table dataTable)
		{
			//TODO:here could be th instead of td 
			var ths = htmlTable.FindElements(By.XPath("./tbody/tr[position()=1]/td"));

			//data rows
			var trs = htmlTable.FindElements(By.XPath("./tbody/tr[position()>1]"));

			//key=column name of htmlTable, value = index of htmlTable
			var indexMapping = new Dictionary<string, int>();
			for (int i = 0; i < ths.Count; i++)
			{
				indexMapping[ths[i].Text] = i;
			}

			int maxTdCounts = 0;
			var matchTrs = trs.Where(tr =>
			{
				var tds = tr.FindElements(By.TagName("td"));

				//skip the trs that have less tds, these trs are not data rows usually.
				maxTdCounts = Math.Max(tds.Count, maxTdCounts);
				if (tds.Count != maxTdCounts)
					return false;

				//Is there ***ANY*** datarow that ***ALL*** columns match the html row's columns

				return dataTable.Rows.Any(dr =>
				{
					return dr.All(x => x.Value == tds[indexMapping[x.Key]].Text);
				});

			});


			return new ReadOnlyCollection<IWebElement>(matchTrs.ToList());
		}


        public static void SetText(this IWebElement driver, string text)
        {
            driver.Clear();
            driver.SendKeys(text);
        }

		public static void TryExecuteJavascript(this RemoteWebDriver driver, string script)
		{
			try
			{
				driver.ExecuteScript(script);
			}
			catch
			{
			}
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

		public static void SetAttribute(this IWebElement element, string attributeName, string value)
		{
			GetJsExecutor(element).ExecuteScript("arguments[0].setAttribute(arguments[1], arguments[2])", element, attributeName, value);
		}
		
		public static void RemoveAttribute(this IWebElement element, string attributeName)
		{
			GetJsExecutor(element).ExecuteScript("arguments[0].removeAttribute(arguments[1])", element, attributeName);
		}

		public static IWebElement TryFindElementBy(this ISearchContext driver,  By by)
		{
			IWebElement ele = null;
			try
			{
				ele = driver.FindElement(by);
			}
			catch
			{
			}
			return ele;
		}

		public static IWebElement TryFindElementById(this RemoteWebDriver driver, string Id)
		{
			IWebElement ele = null;
			try
			{
				ele = driver.FindElementById(Id);
			}
			catch
			{
			}
			return ele;
		}
		
		public static IWebElement TryFindElementByName(this RemoteWebDriver driver, string name)
		{
			IWebElement ele = null;
			try
			{
				ele = driver.FindElementByName(name);
			}
			catch
			{
			}
			return ele;
		}
		
		public static IWebElement TryFindElementByLinkText(this RemoteWebDriver driver, string LinkText)
		{
			IWebElement ele = null;
			try
			{
	
				ele = driver.FindElementByLinkText(LinkText);
			}
			catch
			{
			}
			return ele;
		}
	}
}
