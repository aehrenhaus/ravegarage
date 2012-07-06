using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class CRFPage : BaseEDCTreePage
	{

		public CRFPage FillDataPoint(string label, string val)
		{
			RavePagesHelper.FillDataPoint(label, val);
			return this;
		}

		public CRFPage AddLogLine()
		{
			IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_R_log_log_AddLine");
			saveButton.Click();
			return this;
		}

		public CRFPage OpenLastLogline()
		{
			var editButtons = Browser.FindElements(
	By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"));
			editButtons[editButtons.Count-1].Click();
			return this;
		}

		public CRFPage OpenLogline(int lineNum)
		{
			//TODO: this should not work in a non -log line form

			var editButtons = Browser.FindElements(
				By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"));
			editButtons[lineNum-1].Click();
			return this;
		}

		public CRFPage ClickModify()
		{
			IWebElement editButton = Browser.TryFindElementById("_ctl0_Content_R_header_SG_PencilButton");
			if (editButton == null)
				throw new Exception("Can not find the modify button");
			editButton.Click();
			return this;
		}
			
		public CRFPage CancelForm()
		{
			IWebElement btn = Browser.TryFindElementById("_ctl0_Content_R_footer_CB");
			if (btn == null)
				throw new Exception("Can not find the Cancel button");
			btn.Click();
			return this;
		}

		

		public CRFPage SaveForm()
		{
			IWebElement btn = Browser.TryFindElementById("_ctl0_Content_R_footer_SB");
			if (btn == null)
				throw new Exception("Can not find the Save button");
			btn.Click();
			return this;
		}

		#region Query related

		public bool CanFindQuery(QuerySearchFilter filter)
		{
			return CanFindQuery(filter.Field,filter.Message,filter.RR, filter.RC,filter.Closed);
		}

		public bool CanFindQuery(string fieldName, string message = null, bool? requiresResponse = null, bool? requiresClose = null, bool? closed=null)
		{
			IWebElement queryContainer = null;
			try
			{
				queryContainer = FindQuery(fieldName, message, requiresResponse, requiresClose, closed);
			}
			catch
			{
			}
			return queryContainer != null;

		}

		//the table that contains the Query(left side)
		public IWebElement FindQuery(string fieldName, string message = null, bool? requiresResponse = null, bool? requiresClose = null, bool? closed = null)
		{
			var dpLeftTd = RavePagesHelper.GetDatapointLabelContainer(fieldName).EnhanceAs<EnhancedElement>();
			var queryTables = dpLeftTd.FindElements(
					By.XPath(".//td[@class='crf_preText']/table"));
			IWebElement queryTable = null;

			//if message is null, means find the only query
			if (message != null)
			{
				queryTable = queryTables.FirstOrDefault(x => x.Text.LastIndexOf(message) != -1);
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
			var fieldTable = dpLeftTd.Ancestor("table");

			bool isClosed = fieldTable.Class.IndexOf("Warning") == -1;
			if (closed == true && !isClosed)
				throw new Exception("Expect query to be a closed query.");
			if (closed == false && isClosed)
				throw new Exception("Expect query to be a open query.");

			//having the textbox means rr
			bool rr = dpLeftTd.Textboxes().Count==1;
			if (requiresResponse == true && !rr)
				throw new Exception("Expect query to require response.");
			if (requiresResponse == false && rr)
				throw new Exception("Expect query to not require response.");

			//having the dropdown means requires manual close
			bool rc = dpLeftTd.Dropdowns().Count == 1;
			if (requiresClose == true && !rc)
				throw new Exception("Expect query to require close.");
			if (requiresClose == false && rc)
				throw new Exception("Expect query to not require close.");

			return queryTable;
		}

		public CRFPage AnswerQuery(string message, string fieldName, string answer)
		{
			var queryContainer = FindQuery(fieldName, message);
			queryContainer.Textboxes()[0].SetText(answer);
			return this;
		}

		public CRFPage CloseQuery(string message, string fieldName)
		{
			var queryContainer = FindQuery(fieldName, message);
			queryContainer.Dropdowns()[0].SelectByText("Close Query");
		
			return this;
		}

		public CRFPage CancelQuery(string message, string fieldName)
		{
			var queryContainer = FindQuery(fieldName, message);
			queryContainer.Checkboxes()[0].Check();
		
			return this;
		}

		#endregion

	}
}
