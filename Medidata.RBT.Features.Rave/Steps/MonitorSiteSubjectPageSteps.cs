using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.Features;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using System.IO;
using System.Data;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Threading;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT.Common.Steps;
using Medidata.RBT;
using Medidata.RBT.PageObjects.Rave.EDC;

namespace Medidata.RBT.Features.Rave
{
    [Binding]
    public class MonitorSiteSubjectPageSteps : BrowserStepsBase
    {
        [StepDefinition(@"I generate PDF for all visits")]
        public void IGeneratePDFForAllVisits()
        {
            CurrentPage.As<MonitorSiteSubjectPage>().GeneratePDFReport();
        }
    }
}