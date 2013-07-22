using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.Specialized;
using Medidata.RBT.SeleniumExtension;

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
				return Browser.TryFindElementByPartialID("txtSeparator");
			if (identifier == "File type")
				return Browser.TryFindElementByPartialID("ddlFileType");
			if (identifier == "Export type")
				return Browser.TryFindElementByPartialID("ddlExportType");
			if (identifier == "Save as Unicode")
				return Browser.TryFindElementByPartialID("chkEncoding");
			return base.GetElementByName(identifier,areaIdentifier,listItem);
		}

        public override string URL
        {
            get { return "StreamReport.aspx"; }
        }
	}
}
