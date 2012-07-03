using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using System.Diagnostics;
using System.Collections.Specialized;

namespace Medidata.RBT.PageObjects.Rave
{
    public class RWSLogPage : PageBase
    {

        public RWSLogPage(string logger)
        {
            string time = "2012-06-06T00:01:10";
            //TODO - remove following line
            logger = "Medidata.Core.Objects.DeferredRollupQueue";

            Parameters.Add("logger", logger);
            Parameters.Add("Start", time);

            string dialogTitle = "Authentication Required";
            string username = "defuser";
            string password = "password";
            //  Browser.Close();
            // TestContext.Browser = PageBase.OpenBrowser();
            //System.Runtime.getRuntime().exec("C:\\Program Files\\AutoIt3\\Examples\\authenticationFF.exe");


            string filename = RaveConfiguration.Default.RWSAuthanticationFilePath;
            ProcessStartInfo procStartInfo = new ProcessStartInfo(filename);
            procStartInfo.Arguments = string.Format("\"{0}\" \"{1}\" \"{2}\"", dialogTitle, username, password);
            Process proc = new Process();

            proc.StartInfo = procStartInfo;
            proc.Start();

            Browser.Url = GetUrl(URL, Parameters);

            //InitializeWithNewUrl(string.Format("{0}datasets/Logmessagedata?Start={1}&rows=1000&Logger={2}", rwsAppName, time, logger));
            Browser.Url = string.Format("{0}datasets/Logmessagedata?Start={1}&Logger={2}&rows=1000", RaveConfiguration.Default.RWSURL, time, logger);
            string text = Browser.PageSource;
        }

        private string GetUrl(string URL, NameValueCollection Parameters)
        {
            throw new NotImplementedException();
        }


        public override NameValueCollection Parameters
        {
            get
            {
                NameValueCollection param = new NameValueCollection();
                param.Add("rows", "1000");
                return param;
            }
        }

        public string URL { get { return "datasets/Logmessagedata"; } }
    }
}

