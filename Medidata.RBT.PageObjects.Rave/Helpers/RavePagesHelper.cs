using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.PageObjects.Rave
{
	class RavePagesHelper
	{
        public static IWebElement GetDatapointContainer(string label)
        {
            IWebElement leftSideTd = GetDatapointLabelContainer(label);
            //leftSideTd and right side td share same tr. So go up a level, and find the right side
            IWebElement datapointTable = leftSideTd.TryFindElementBy(By.XPath("./../td[@class='crf_rowRightSide']//table[@class='crf_dataPointInternal']"));
            return datapointTable;

        }

        //the table contains field and related data.s
        public static IWebElement GetDatapointLabelContainer(string label)
        {
			//"Assessment Date 1\r\ntet\r\nOpened To Site (06 Jun 2012)\r\nForward\r\nCancel"

            var leftSideTds = TestContext.Browser.FindElements(By.XPath("//td[@class='crf_rowLeftSide']"));
			var area =  leftSideTds.FirstOrDefault(x => x.Text.Split(new string[] { "\r\n" }, StringSplitOptions.None)[0] == label);

			if (area == null)
				throw new Exception("Can't find field area:"+label);

			return area;
        }

		public static void FillDataPoint(string label, string val, bool throwIfNotFound=true)
		{

            var datapointTable = GetDatapointContainer(label);

			var textboxes = datapointTable.FindElements(By.TagName("input"));
			var dropdowns = datapointTable.FindElements(By.TagName("select")).ToList();
		
			//this dropdown does count
			var dataEntyErrorDropdown = dropdowns.FirstOrDefault(x =>
				{
					var options = new SelectElement(x).Options;
					return options.Count == 1 && (options[0].Text == "Data Entry Error"||options[0].Text == "Entry Error");
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
                textboxes[0].SetText(dateParts[0]);
				new SelectElement(dropdowns[0]).SelectByValue(dateParts[1]);
				textboxes[1].SetText(dateParts[2]);
			}
			else if (textboxes.Count == 1 && dropdowns.Count == 0) //normal text filed
			{
				textboxes[0].SetText(val);
			}
			else
			{
				if(throwIfNotFound)
					throw new Exception("Not sure what kind of datapoint is this.");
			}
		}

		public static IWebElement FindLinkInPaginatedList(string linkText)
		{
			IWebElement ele = null;
			int pageIndex = 1;
			int count = 0;
			do
			{
				ele = TestContext.Browser.TryFindElementByLinkText(linkText);
				if (ele != null)
					break;
				var pageTable = TestContext.Browser.FindElementById("_ctl0_Content_ListDisplayNavigation_DlPagination");
				var pageLinks = pageTable.FindElements(By.XPath(".//a"));
				count = pageLinks.Count;
				if (pageIndex == count)
					break;

				pageLinks[pageIndex].Click();
				pageIndex++;
			} while (true);

			return ele;
		}
	}
}
