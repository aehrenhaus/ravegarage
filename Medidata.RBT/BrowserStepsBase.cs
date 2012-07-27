using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Drawing.Imaging;

namespace Medidata.RBT
{

	public class BrowserStepsBase
	{
	
		public RemoteWebDriver Browser
		{
			get
			{
				return TestContext.Browser;
			}
			set
			{

				TestContext.Browser = value;
			}
		}


		public IPage CurrentPage
		{
			get
			{
				return TestContext.CurrentPage;

			}
			set
			{
				TestContext.CurrentPage= value;
			}
		}

	
	}



}
