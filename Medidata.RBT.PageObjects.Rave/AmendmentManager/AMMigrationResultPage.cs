using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Threading;
namespace Medidata.RBT.PageObjects.Rave.AmendmentManager
{
	public class AMMigrationResultPage : RavePageBase
	{

		public void WaitForComplete()
		{
			int timeout = 960;
			var span = Browser.TryFindElementBy(b=>
				{
                    Thread.Sleep(2000);
					var firstJob = Browser.TryFindElementByPartialID("_lblStatusValue");
					if(firstJob.Text=="Complete")
						return firstJob;
					
					this.Browser.Navigate().Refresh();
					return null;

				},true, timeout);
			if (span==null)
				throw new Exception("Takes forever to complete");
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
