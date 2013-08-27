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
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.ConfigurationHandlers;

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
                    string[] reportUrls = RaveConfigurationGroup.Default.ReportURL.Split(',');
                    if (Browser != null && !string.IsNullOrEmpty(Browser.Url))
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
