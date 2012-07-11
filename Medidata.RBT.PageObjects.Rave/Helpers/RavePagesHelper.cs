using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	/// <summary>
	/// This class can get really ugly
	/// </summary>
	class RavePagesHelper
	{
		//-----------STRUCTURE Lab form:
		//span id="_ctl0_Content_R"
		//table 1 lab dropdown
		//table 2
		//    tr class="evenRow" width="100%
		//        td 2 Label
		//        td 4 
		//            table
		//                td 1 
		//                    input

		//        td 5 Range status
		//        td 6 Unit
		//        td 7 Range
		//        td 8
		//            table (pen and other action controls)
		//		tr(next to the above)
		//		td2
		//			table
		//				tr1
		//					td 2 Query message<br>....,cancel box
		//				tr2
		//					td2 answer <br> dropdown answer textbox
		//			table(other query)


		//-------------STRUCTURE for noe-lab form
		//span id="_ctl0_Content_R"
		//    table 1 summary
		//    table 2 
		//        tr 1 class=breaker herader
		//        tr 2+
		//            td
		//                table class=evenWarning width=100%
		//                    tr
		//                        td 1 class="crf_rowLeftSide
		//                            tab;e
		//                                tr
		//                                    td crf_preText
		//                                        Message and <br> table
		//                        td 3 class=crf_rowRightSide


        private static IWebElement GetNonlabDatapointContainer(string label)
        {
            IWebElement leftSideTd = GetNonlabDatapointLabelContainer(label);
            //leftSideTd and right side td share same tr. So go up a level, and find the right side
            IWebElement datapointTable = leftSideTd.TryFindElementBy(By.XPath("./../td[@class='crf_rowRightSide']//table[@class='crf_dataPointInternal']"));
            return datapointTable;

        }

        //the table contains field and related data.s
		private static IWebElement GetNonlabDatapointLabelContainer(string label)
        {
			//"Assessment Date 1\r\ntet\r\nOpened To Site (06 Jun 2012)\r\nForward\r\nCancel"

            var leftSideTds = TestContext.Browser.FindElements(By.XPath("//td[@class='crf_rowLeftSide']"));
			var area =  leftSideTds.FirstOrDefault(x => x.Text.Split(new string[] { "\r\n" }, StringSplitOptions.None)[0] == label);

			if (area == null)
				throw new Exception("Can't find field area:"+label);

			return area;
        }

		public static void FillDataPoints(IEnumerable<FieldModel> fields)
		{

			IWebElement contentR = TestContext.Browser.TryFindElementByPartialID("Content_R");
			if(contentR==null)
				contentR = TestContext.Browser.TryFindElementByPartialID("CRFRenderer");

			var labDropdown = contentR.Dropdown("LOC_DropDown", true);
			bool isLabform = labDropdown != null;

			//but from now on the html is different for lab form
			if (!isLabform)
			{
				foreach (var f in fields)
				{
					FillNonlabDataPoint(f.Field, f.Data);
				}
			}
			else
			{
				var fieldTRs = contentR.FindElements(By.XPath("table[2]/tbody/tr[@width='100%']"));
				foreach (var f in fields)
				{
					var fieldTR = fieldTRs.FirstOrDefault(x => x.Children()[1].Text == f.Field);
					fieldTR.Textboxes()[0].SetText(f.Data);

				}
			}
			
		}

		private static void FillNonlabDataPoint(string label, string val, bool throwIfNotFound=true)
		{

            var datapointTable = GetNonlabDatapointContainer(label);

			var textboxes = datapointTable.Textboxes();
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

		//TODO: this just find subject in list, later maybe extract the pagin logic to a seperate method
        public static IWebElement FindLinkInPaginatedList(string linkText)
        {
            IWebElement ele = null;
            int pageIndex = 1;
            int count = 0;
            int lastValue = -1;
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

                while (!pageLinks[pageIndex].Text.Equals("...") && int.Parse(pageLinks[pageIndex].Text) <= lastValue && pageIndex <= count)
                {
                    pageIndex++;
                }

                if (pageLinks[pageIndex].Text.Equals("..."))
                {
                    lastValue = int.Parse(pageLinks[pageIndex - 1].Text);
                    pageLinks[pageIndex].Click();
                    pageIndex = 1;
                }
                else
                {
                    pageLinks[pageIndex].Click();
                    pageIndex++;
                }
            } while (true);

            return ele;
        }

		private static  IWebElement FindNonlabQueryTable(QuerySearchModel filter)
		{
			var dpLeftTd = RavePagesHelper.GetNonlabDatapointLabelContainer(filter.Field).EnhanceAs<EnhancedElement>();
			var queryTables = dpLeftTd.FindElements(
					By.XPath(".//td[@class='crf_preText']/table"));
			IWebElement queryTable = null;

			//if message is null, means find the only query
			if (filter.QueryMessage != null)
			{
				queryTable = queryTables.FirstOrDefault(x => x.Text.LastIndexOf(filter.QueryMessage) != -1);
				if (queryTable == null)
					throw new Exception("Query not found");
			}
			else
			{
				if (queryTables.Count != 1)
					throw new Exception("Expecting only one query on field");
				queryTable = queryTables[0];
			}


			//is closed query?
			if (filter.Closed != null)
			{
				var fieldTable = dpLeftTd.Ancestor("table");

				bool isClosed = fieldTable.Class.IndexOf("Warning") == -1;
				if (filter.Closed == true && !isClosed)
					throw new Exception("Expect query to be a closed query.");
				if (filter.Closed == false && isClosed)
					throw new Exception("Expect query to be a open query.");
			}

			//having the textbox means rr
			if (filter.Response != null)
			{
				bool rr = dpLeftTd.Textboxes().Count == 1;
				if (filter.Response == true && !rr)
					throw new Exception("Expect query to require response.");
				if (filter.Response == false && rr)
					throw new Exception("Expect query to not require response.");
			}

			//having the dropdown means requires manual close
			if (filter.ManualClose != null)
			{
				bool rc = dpLeftTd.Dropdowns().Count == 1;
				if (filter.ManualClose == true && !rc)
					throw new Exception("Expect query to require close.");
				if (filter.ManualClose == false && rc)
					throw new Exception("Expect query to not require close.");
			}

			if (filter.Answered != null)
			{
				//TODO: answered for non-lab form
			}


			if (filter.Answer != null)
			{
				//TODO: Answer for non-lab form
			}

		

			return queryTable;
		}

		//the table that contains the Query(left side)
		public static IWebElement FindQuery(QuerySearchModel filter)
		{

			//There are some across different form
			var contentR = TestContext.Browser.FindElementsByPartialId("Content_R")[0];
			var labDropdown = contentR.Dropdown("LOC_DropDown", true);
			bool isLabform = labDropdown != null;

			//but from now on the html is different for lab form
			if (!isLabform)
			{

				return FindNonlabQueryTable(filter);
				
			}
			else
			{
				var fieldTRs = contentR.FindElements(By.XPath("table[2]/tbody/tr"));
				int i = 0;
				
				for (; i < fieldTRs.Count; i++)
				{
					if(fieldTRs[i].Children()[1].Text == filter.Field)
						break;
				}
				IWebElement fieldTR = fieldTRs[i];
				IWebElement fieldTRQueries = fieldTRs[i+1];
				//each table is a query
				IWebElement queryTable = null;
				
				var queryTables = fieldTRQueries.FindElements(By.XPath("./td[2]/table"));
				if (filter.QueryMessage == null)
				{
					if (queryTables.Count != 1)
						throw new Exception("Expecting only one query on field if message is not provieded");
					queryTable = queryTables.FirstOrDefault();
				}
				else
					queryTable = queryTables.FirstOrDefault(x => x.FindElement(By.XPath("./tbody/tr/td[2]")).Text.Contains(filter.QueryMessage));


				//TODO: check other properties in Filter

				if (queryTable == null)
					throw new Exception("Can't find labform query on field: "+filter.Field);
				return queryTable;
				
			}
			



			throw new Exception ("should not get here");
		}

	}
}
