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
			var queryTables = QueriesTR.FindElements(By.XPath("./td[2]/table"));
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


		public void Check(string checkName)
		{
			if (checkName == "Freeze")
			{
				MainTR.Checkbox("EntryLockBox").Check();
			}

			if (checkName == "Hard Lock")
			{
				MainTR.Checkbox("HardLockBox").Check();
			}
		}

		public void Uncheck(string checkName)
		{
			throw new NotImplementedException();
		}
	}
}
