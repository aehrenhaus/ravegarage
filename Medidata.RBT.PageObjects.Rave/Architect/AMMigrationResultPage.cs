using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
namespace Medidata.RBT.PageObjects.Rave
{
	public class AMMigrationResultPage : RavePageBase
	{

		public void WaitForComplete()
		{
			int timeout = 500;
			var span = Browser.WaitForElement(b=>
				{
					var firstJob = Browser.TryFindElementByPartialID("_lblStatusValue");
					if(firstJob.Text=="Complete")
						return firstJob;
					return null;
				},"Take forever to complete", timeout);

		}

		public override string URL
		{
			get
			{
				return "Modules/AmendmentManager/MigrationResults.aspx";
			}
		}

	}
}
