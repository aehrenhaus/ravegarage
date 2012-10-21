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
    public class CrystalReportPage : RavePageBase
	{
		public CrystalReportPage()
		{
			
		}
        public override string URL
        {
            get { return "CrystalReportViewer.aspx"; }
        }
	}
}
