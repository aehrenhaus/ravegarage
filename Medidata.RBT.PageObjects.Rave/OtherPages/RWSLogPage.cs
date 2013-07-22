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
    public class RWSLogPage : RavePageBase
    {
		public RWSLogPage()
		{
		}

		public RWSLogPage(WebTestContext context)
			: base(context)
		{
		}

        public RWSLogPage(string logger)
        {
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

            //Browser.Url = GetUrl(URL, Parameters);

			NavigateToSelf();
			//Browser.Url = string.Format("{0}datasets/Logmessagedata?Start={1}&Logger={2}&rows=1000", RaveConfiguration.Default.RWSURL, time, logger);
            string text = Browser.PageSource;
        }

        private string GetUrl(string URL, NameValueCollection Parameters)
        {
            throw new NotImplementedException();
        }

		public override IPage NavigateToSelf(NameValueCollection parameters = null)
		{
			if (parameters == null)
				parameters = new NameValueCollection();

			parameters["rows"] = parameters["rows"] ?? "1000";
			parameters["logger"] = parameters["logger"] ?? "Medidata.Core.Objects.DeferredRollupQueue";
			parameters["Start"] = parameters["Start"] ?? "2012-06-06T00:01:10";
		
			return base.NavigateToSelf(parameters);
		}

        public override string URL { get { return "datasets/Logmessagedata"; } }
    }
}

