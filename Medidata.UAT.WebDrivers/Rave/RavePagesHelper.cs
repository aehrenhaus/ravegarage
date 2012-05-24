using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Medidata.UAT.WebDrivers.Rave
{
	class RavePagesHelper
	{
		public static void FillDataPoint(string label, string val, bool throwIfNotFound=true)
		{
			IWebElement labelTD = TestContextSetup.Browser.FindElement(By.XPath("//td[text()='" + label + "']"));
			IWebElement datapointTable = labelTD.FindElement(By.XPath("./ancestor::table/ancestor::tr//table[@class='crf_dataPointInternal']"));
			
			//if query presents, there will be a nobr arround the datapoint inputs.
			IWebElement nobr = datapointTable.TryFindElementBy(By.TagName("nobr"));
			if (nobr != null)
				datapointTable = nobr;

			var textboxes = datapointTable.FindElements(By.TagName("input"));
			var dropdowns = datapointTable.FindElements(By.TagName("select"));


			if (textboxes.Count == 2 && dropdowns.Count == 1)//date field  .format: dd MM yyyy
			{
				string[] dateParts = val.Split(' ');
				if (dateParts.Length != 3)
				{
					throw new Exception("Expection date format for field " + label + " , got: " + val);
				}
				//assign 3 parts of the date format
				textboxes[0].SendKeys(dateParts[0]);
				new SelectElement(dropdowns[0]).SelectByValue(dateParts[1]);
				textboxes[1].SendKeys(dateParts[2]);
			}
			else if (textboxes.Count == 1 && dropdowns.Count == 0) //normal text filed
			{
				textboxes[0].SendKeys(val);
			}
			else
			{
				if(throwIfNotFound)
					throw new Exception("Not sure what kind of datapoint is this.");
			}
		}
	}
}
