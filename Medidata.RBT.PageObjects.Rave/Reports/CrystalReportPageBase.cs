using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using System.Collections.ObjectModel;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.PageObjects.Rave
{
    public abstract class CrystalReportPageBase : RavePageBase
    {
        public override string BaseURL
        {
            get
            {
                try
                {
                    string[] reportUrls = RaveConfiguration.Default.ReportURL.Split(',');
                    if (!string.IsNullOrEmpty(Browser.Url))
                    {
                        foreach (string reportUrl in reportUrls)
                        {
                            if (Browser.Url.StartsWith(reportUrl, StringComparison.InvariantCultureIgnoreCase))
                                return reportUrl;
                        }
                    }
                }
                catch { }

                return base.BaseURL;
            }
        }
    }
}
