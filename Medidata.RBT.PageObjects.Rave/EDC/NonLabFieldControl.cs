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
			foreach (var tmpQueryTable in queryTables)
			{
				if (filter.QueryMessage != null && tmpQueryTable.Text.LastIndexOf(filter.QueryMessage) == -1)
					continue;

				var hasDropdown = tmpQueryTable.Dropdowns().Count == 1;
				var hasCancelCheck = tmpQueryTable.Checkboxes().Count == 1;
				var hasReplyTextbox = tmpQueryTable.Textboxes().Count == 1;


				if (filter.Closed != null)
				{
					bool actualClosed = !hasDropdown && !hasCancelCheck && !hasReplyTextbox;
					if (filter.Closed == true && !actualClosed)
						continue;
					if (filter.Closed == false && actualClosed)
						continue;
				}


				if (filter.Response != null)
				{
					bool actualRequireResponse = hasReplyTextbox;
					if (filter.Response == true && !actualRequireResponse)
						continue;
					if (filter.Response == false && actualRequireResponse)
						continue;
				}

				//having the dropdown means requires manual close
				if (filter.ManualClose != null)
				{
					bool actualRequireClose = hasDropdown;
					if (filter.ManualClose == true && !actualRequireClose)
						continue;
					if (filter.ManualClose == false && actualRequireClose)
						continue;
				}

				var answerTD = tmpQueryTable.TryFindElementBy(By.XPath("./tbody/tr[2]/td[2]"));

				if (filter.Answered != null)
				{
					if (filter.Answered == true && answerTD.Text.Trim() == "")
						continue;

					if (filter.Answered == false)
						if (answerTD != null && answerTD.Text.Trim() != "")
							continue;
				}


				if (filter.Answer != null)
				{
					if (!(answerTD != null && answerTD.Text.Trim() == filter.Answer))
						continue;
				}

				queryTable = tmpQueryTable;
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
			string answer = filter.Answer;
			filter.Answer = null;
			FindQuery(filter).Textboxes()[0].SetText(answer);
		}


		public void CloseQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Dropdowns()[0].SelectByText("Close Query");
		}


		public void CancelQuery(QuerySearchModel filter)
		{
			FindQuery(filter).Checkboxes()[0].Check();
		}

		public void Check(string checkName)
		{
			if (checkName == "Freeze")
			{
				RightSideTD.Checkbox("EntryLockBox").Check();
			}

			if (checkName == "Hard Lock")
			{
				RightSideTD.Checkbox("HardLockBox").Check();
			}
		}

		public void Uncheck(string checkName)
		{
			throw new NotImplementedException();
		}

		#endregion

	}
}
