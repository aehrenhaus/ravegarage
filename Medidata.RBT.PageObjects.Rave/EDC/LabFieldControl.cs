using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;

namespace Medidata.RBT.PageObjects.Rave
{
	public class LabFieldControl:ControlBase, IEDCFieldControl
	{
		public LabFieldControl(IPage page, IWebElement MainTR, IWebElement QueriesTR)
			: base(page)
		{
			this.MainTR = MainTR.EnhanceAs < EnhancedElement>();
			this.QueriesTR = QueriesTR.EnhanceAs<EnhancedElement>();
		}


		private EnhancedElement MainTR;
		private EnhancedElement QueriesTR;


		#region IEDCFieldControl

		public AuditsPage ClickAudit()
		{
			var auditButton = MainTR.TryFindElementByPartialID("DataStatusHyperlink");
			auditButton.Click();
			return new AuditsPage();
		}

		public void EnterData(string text)
		{
			var textbox = MainTR.Textboxes()[0];
			textbox.SetText(text);
		}

		public IWebElement FindQuery(QuerySearchModel filter)
		{
		
			//each table is a query
			IWebElement queryTable = null;

			var queryTables = QueriesTR.FindElements(By.XPath("./td[2]/table"));
			if (filter.QueryMessage == null)
			{
				if (queryTables.Count != 1)
					throw new Exception("Expecting only one query on field if message is not provieded");
				queryTable = queryTables.FirstOrDefault();
			}
			else
				queryTable = queryTables.FirstOrDefault(x => x.FindElement(By.XPath("./tbody/tr/td[2]")).Text.Contains(filter.QueryMessage));

			if (queryTable == null)
				throw new Exception("Can't find labform query on field: " + filter.Field);


			var hasDropdown = queryTable.Dropdowns().Count == 1;
			var hasCancelCheck = queryTable.Checkboxes().Count == 1;
			var hasReplyTextbox = queryTable.Textboxes().Count == 1;


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
				if (filter.Answered == true && answerTD.Text.Trim() == "")
					throw new Exception("Expect to be answered , but not answered");

				if (filter.Answered == false)
					if (answerTD != null && answerTD.Text.Trim() != "")
						throw new Exception("Expect to be not answered , but answered");
			}


			if (filter.Answer != null)
			{
				if (answerTD != null && answerTD.Text.Trim() == filter.Answer)
					;
				else
					throw new Exception("Not answered with " + filter.Answer);
			}

			return queryTable;
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


		#endregion
	}
}
