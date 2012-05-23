using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Firefox;
using Medidata.UAT.WebDrivers;
using OpenQA.Selenium;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Drawing.Imaging;

namespace Medidata.UAT.Features
{

	public class FeatureStepsUsingBrowser 
	{
	

		public RemoteWebDriver Browser
		{
			get
			{
				return TestContextSetup.Browser;
			}
			set
			{

				TestContextSetup.Browser = value;
			}
		}


		public PageBase CurrentPage
		{
			get
			{
				return TestContextSetup.CurrentPage;

			}
			set
			{
				TestContextSetup.CurrentPage= value;
			}
		}

	
	}



}
