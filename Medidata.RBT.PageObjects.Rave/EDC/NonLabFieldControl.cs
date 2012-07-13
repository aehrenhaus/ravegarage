using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;
using OpenQA.Selenium.Support.UI;

namespace Medidata.RBT.PageObjects.Rave
{
	public class NonLabFieldControl:ControlBase, IEDCFieldControl
	{
		public NonLabFieldControl(IPage page, IWebElement LeftSideTD, IWebElement RightSideTD)
			: base(page)
		{
			this.LeftSideTD = LeftSideTD.EnhanceAs < EnhancedElement>();
			this.RightSideTD = RightSideTD.EnhanceAs<EnhancedElement>();
			FieldName = "";
		}

		private EnhancedElement LeftSideTD;
		private EnhancedElement RightSideTD;

		public string FieldName { get; private set; }
	
		#region IEDCFieldControl

		public AuditsPage ClickAudit()
		{
			var auditButton = RightSideTD.TryFindElementByPartialID("DataStatusHyperlink");
			auditButton.Click();
			return new AuditsPage();
		}

		public IWebElement FindQuery(QuerySearchModel filter)
		{

			var queryTables = LeftSideTD.FindElements(
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

			var hasDropdown = LeftSideTD.Dropdowns().Count == 1;
			var hasCancelCheck = LeftSideTD.Checkboxes().Count == 1;
			var hasReplyTextbox = LeftSideTD.Textboxes().Count == 1;

			//is closed query?
			if (filter.Closed != null)
			{
				bool isClosed = !hasDropdown && !hasCancelCheck && !hasReplyTextbox;
				if (filter.Closed == true && !isClosed)
					throw new Exception("Expect query to be a closed query.");
				if (filter.Closed == false && isClosed)
					throw new Exception("Expect query to be a open query.");
			}

		

			//having the textbox means rr
			if (filter.Response != null)
			{
				bool rr = hasReplyTextbox;
				if (filter.Response == true && !rr)
					throw new Exception("Expect query to require response.");
				if (filter.Response == false && rr)
					throw new Exception("Expect query to not require response.");
			}

			//having the dropdown means requires manual close
			if (filter.ManualClose != null)
			{
				bool rc = hasDropdown;
				if (filter.ManualClose == true && !rc)
					throw new Exception("Expect query to require close.");
				if (filter.ManualClose == false && rc)
					throw new Exception("Expect query to not require close.");
			}

			var answerTD = queryTable.TryFindElementBy(By.XPath("./tbody/tr[2]/td[2]"));
			
			if (filter.Answered != null)
			{
				if (answerTD != null && answerTD.Text.Trim() != "")
					;
				else
					throw new Exception("not answered");
			}


			if (filter.Answer != null)
			{
				if (answerTD != null && answerTD.Text.Trim() == filter.Answer)
					;
				else
					throw new Exception("not answered with "+filter.Answer);
			}



			return queryTable;
	
		}

		public void EnterData(string text)
		{
			IWebElement datapointTable = LeftSideTD.TryFindElementBy(By.XPath("./../td[@class='crf_rowRightSide']//table[@class='crf_dataPointInternal']"));

			var textboxes = datapointTable.Textboxes();
			var dropdowns = datapointTable.FindElements(By.TagName("select")).ToList();

			//this dropdown does count
			var dataEntyErrorDropdown = dropdowns.FirstOrDefault(x =>
			{
				var options = new SelectElement(x).Options;
				return options.Count == 1 && (options[0].Text == "Data Entry Error" || options[0].Text == "Entry Error");
			});
			//	int dataEntyErrorDropdownCount = dataEntyErrorDropdown == null ? 0 : 1;
			//int datapointDropdownCount =  dropdowns.Count - dataEntyErrorDropdownCount ;
			if (dataEntyErrorDropdown != null)
				dropdowns.Remove(dataEntyErrorDropdown);

			if (textboxes.Count == 2 && dropdowns.Count == 1)//date field  .format: dd MM yyyy
			{
				string[] dateParts = text.Split(' ');
				if (dateParts.Length != 3)
				{
					throw new Exception("Expection date format for field " + FieldName + " , got: " + text);
				}
				//assign 3 parts of the date format
				textboxes[0].SetText(dateParts[0]);
				new SelectElement(dropdowns[0]).SelectByValue(dateParts[1]);
				textboxes[1].SetText(dateParts[2]);
			}
			else if (textboxes.Count == 1 && dropdowns.Count == 0) //normal text filed
			{
				textboxes[0].SetText(text);
			}
			else
			{
				throw new Exception("Not sure what kind of datapoint is this.");
			}
		}

		public void AnswerQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Textboxes()[0].SetText(filter.Answer);
		}


		public void CloseQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Dropdowns()[0].SelectByText("Close Query");
		}


		public void CancelQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Checkboxes()[0].Check();
		}

		#endregion

	}
}
