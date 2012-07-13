using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;

namespace Medidata.RBT.PageObjects.Rave
{
	public class LabFieldControl:ControlBase, IEDCFieldControl
	{
		public LabFieldControl(IPage page, IWebElement ele)
			: base(page, ele)
		{
		}

		public AuditsPage ClickAudit()
		{
			throw new NotImplementedException();
		}
	}
}
