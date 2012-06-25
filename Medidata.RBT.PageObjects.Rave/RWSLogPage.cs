using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using System.Diagnostics;

namespace Medidata.RBT.PageObjects.Rave
{
    public class RWSLogPage : PageBase
    {

        public RWSLogPage(string rwsAppName, string logger, string authPath)
        {
            string time = "2012-06-06T00:01:10";
            //TODO - remove following line
            logger = "Medidata.Core.Objects.DeferredRollupQueue";

            string dialogTitle = "Authentication Required";
            string username = "defuser";
            string password = "password";
          //  Browser.Close();
           // TestContext.Browser = PageBase.OpenBrowser();
            //System.Runtime.getRuntime().exec("C:\\Program Files\\AutoIt3\\Examples\\authenticationFF.exe");


            string filename = authPath;
            ProcessStartInfo procStartInfo = new ProcessStartInfo(filename);
            procStartInfo.Arguments = string.Format("\"{0}\" \"{1}\" \"{2}\"", dialogTitle, username, password);
            Process proc = new Process();

            proc.StartInfo = procStartInfo;
            proc.Start();

            //InitializeWithNewUrl(string.Format("{0}datasets/Logmessagedata?Start={1}&rows=1000&Logger={2}", rwsAppName, time, logger));
            Browser.Url = string.Format("{0}datasets/Logmessagedata?Start={1}&rows=1000&Logger={2}", rwsAppName, time, logger);
            string text = Browser.PageSource;
        }

    }
}
