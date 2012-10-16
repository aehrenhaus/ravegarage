using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using System.Threading;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectPushPage :  RavePageBase
	{
		public IPage PushToSites(string env, string sites)
		{
			if (sites == "All Sites")
			{
				return PushToAllSites(env);
			}
			throw new NotImplementedException();
		}


		public IPage PushToAllSites(string env)
		{
			Browser.DropdownById("StudyDDL").SelectByText(env);
			Thread.Sleep(1000);
			this.ClickButton("Push");
			Browser.WaitForElement(b =>
			{
				var span = Browser.Span("SuccessMessageLBL");
				if (span.Text == "")
					return null;
				return span;
			});
			return this;
		}

		public override string URL
		{
			get
			{
				return "Modules/Architect/Push.aspx";
			}
		}
	}
}
