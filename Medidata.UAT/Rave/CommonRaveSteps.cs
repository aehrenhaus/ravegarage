using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.UAT.Features;
using TechTalk.SpecFlow;
using Medidata.UAT.WebDrivers;
using Medidata.UAT.WebDrivers.Rave;

namespace Medidata.UAT.Features.Rave
{
	[Binding]
	public class CommonRaveSteps : FeatureStepsUsingBrowser
	{

		[When(@"I login")]
		public void ILogin()
		{
			string url = "http://localhost/Rave564/Login.aspx";
			CurrentPage = PageBase.GotoUrl<LoginPage>(Browser, url);
			CurrentPage = CurrentPage.As<LoginPage>().Login("cdm1", "password");
		}

	}
}
