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

		public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
		{
			if (identifier == "Separator")
				return this.WaitForElement("txtSeparator");
			if (identifier == "File type")
				return WaitForElement("ddlFileType");
			if (identifier == "Export type")
				return WaitForElement("ddlExportType");
			if (identifier == "Save as Unicode")
				return WaitForElement("chkEncoding");
			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}
	}
}
