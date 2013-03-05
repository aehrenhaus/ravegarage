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
		public SpecflowWebTestContext SpecflowContext
		{
			get
			{
				return (SpecflowStaticBindings.Current as SpecflowWebTestContext);
			}

		}

		public WebTestContext WebTestContext
		{
			get
			{
				return SpecflowContext.WebTestContext;
			}
	
		}

		public RemoteWebDriver Browser
		{
			get
			{
				return WebTestContext.Browser;
			}
			set
			{
				WebTestContext.Browser = value;
			}
		}

		public IPage CurrentPage
		{
			get
			{
				return WebTestContext.CurrentPage;
			}
			set
			{
				WebTestContext.CurrentPage= value;
			}
		}

        public string CurrentUser
        {
            get
            {
                return WebTestContext.CurrentUser;
            }
            set
            {
                WebTestContext.CurrentUser = value;
            }
        }
	}
}
