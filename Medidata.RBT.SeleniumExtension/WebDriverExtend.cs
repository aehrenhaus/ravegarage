using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Internal;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.SeleniumExtension
{
	public static class WebDriver
	{
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
	}
}
