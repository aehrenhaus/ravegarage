using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium;
using System.IO;
using System.Drawing.Imaging;

namespace Medidata.UAT
{
	[Binding]
	public class TestContextSetup
	{

		public static RemoteWebDriver Browser
		{
			get
			{
				if (!ScenarioContext.Current.ContainsKey("RemoteWebDriver"))
				{
					return null;
				}
				return ScenarioContext.Current["RemoteWebDriver"] as RemoteWebDriver;

			}
			set
			{

				ScenarioContext.Current["RemoteWebDriver"] = value;
			}
		}


		public static PageBase CurrentPage
		{
			get
			{
				if (!ScenarioContext.Current.ContainsKey("PageBase"))
				{
					return null;
				}
				return ScenarioContext.Current["PageBase"] as PageBase;

			}
			set
			{
				ScenarioContext.Current["PageBase"] = value;
			}
		}



		[BeforeScenario("Web")]
		public void ScenarioSetup()
		{
			if (Browser == null)
			{
				Browser = PageBase.OpenBrowser();
			}
		}

		[AfterScenario("Web")]
		public void ScenarioTearDown()
		{
			if (Browser != null)
			{
				TrySaveScreenShot(Browser);
				
				if(UATConfiguration.Default.AutoCloseBrowser)
					Browser.Close();
				Browser = null;
			}

		}

		private void TrySaveScreenShot(RemoteWebDriver driver)
		{
			try
			{
				if (Browser is ITakesScreenshot)
				{
					string scenarioName = ReplaceIlligalFileNameChars(ScenarioContext.Current.ScenarioInfo.Title);
					string featureName = ReplaceIlligalFileNameChars("feature Name");
					string time = DateTime.Now.ToString().Replace(":", "-").Replace("/", "-");

					//file path
					string screenshotPath = Path.Combine(
						UATConfiguration.Default.ScreenShotPath,
						featureName,
						scenarioName,
						time + ".jpg");

					Directory.CreateDirectory(new FileInfo(screenshotPath).DirectoryName);
					var screenShot = ((ITakesScreenshot)Browser).GetScreenshot();
					screenShot.SaveAsFile(screenshotPath, ImageFormat.Jpeg);

				}
			}
			catch
			{
			}
		}

		private string ReplaceIlligalFileNameChars(string name)
		{
			//TODO: implment
			return name;
		}
	}
}
