using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;

namespace Medidata.RBT.PageObjects.Rave
{
    public class StreamReportPage : RavePageBase
	{
		public StreamReportPage()
		{
			
		}

		public override IWebElement GetElementByName(string name)
		{
			if (name == "Separator")
				return this.WaitForElement("txtSeparator");
			if (name == "File type")
				return WaitForElement("ddlFileType");
			if (name == "Export type")
				return WaitForElement("ddlExportType");
			if (name == "Save as Unicode")
				return WaitForElement("chkEncoding");
			return base.GetElementByName(name);
		}
	}
}
