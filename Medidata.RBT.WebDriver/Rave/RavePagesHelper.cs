using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.WebDriver.Rave
{
	class RavePagesHelper
	{
		public static void FillDataPoint(string label, string val, bool throwIfNotFound=true)
		{
			IWebElement labelTD = TestContext.Browser.FindElement(By.XPath("//td[text()='" + label + "']"));
			IWebElement datapointTable = labelTD.FindElement(By.XPath("./ancestor::table/ancestor::tr//table[@class='crf_dataPointInternal']"));
			

			var textboxes = datapointTable.FindElements(By.TagName("input"));
			var dropdowns = datapointTable.FindElements(By.TagName("select")).ToList();
		
			//this dropdown does count
			var dataEntyErrorDropdown = dropdowns.FirstOrDefault(x =>
				{
					var options = new SelectElement(x).Options;
					return options.Count == 1 && options[0].Text == "Data Entry Error";
				});
		//	int dataEntyErrorDropdownCount = dataEntyErrorDropdown == null ? 0 : 1;
			//int datapointDropdownCount =  dropdowns.Count - dataEntyErrorDropdownCount ;
			if (dataEntyErrorDropdown != null)
				dropdowns.Remove(dataEntyErrorDropdown);

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
