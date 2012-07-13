using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.IE;
using System.IO;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;


namespace Medidata.RBT
{
    public class ControlBase : IControl
    {
		public ControlBase(IPage page)
		{
			this.Page = page;
		}

		public IPage Page
		{
			get;
			protected set;
		}
	}
}
