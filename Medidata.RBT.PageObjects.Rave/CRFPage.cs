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
		public CRFPage FillDataPoints(IEnumerable<FieldModel> fields)
		{
			RavePagesHelper.FillDataPoints(fields);
			
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


		public bool CanFindQuery(QuerySearchModel filter)
		{
			IWebElement queryContainer = null;
			try
			{
				queryContainer = RavePagesHelper.FindQuery(filter);
			}
			catch
			{
			}
			return queryContainer != null;

		}

		//the table that contains the Query(left side)
		public IWebElement FindQuery(QuerySearchModel filter)
		{
		
			return RavePagesHelper.FindQuery(filter);
		}

		public CRFPage AnswerQuery(string message, string fieldName, string answer)
		{
			var queryContainer = FindQuery(new QuerySearchModel { Message = message, Field = fieldName });
			queryContainer.Textboxes()[0].SetText(answer);
			return this;
		}

		public CRFPage AnswerQuery(QuerySearchModel model)
		{
			var queryContainer = FindQuery(model);
			var boxes = queryContainer.Textboxes();
			if(boxes.Count==0)
				throw new Exception ("Can't find answer textbox");
			boxes[0].SetText(model.Answer);
			return this;
		}

		public CRFPage CloseQuery(string message, string fieldName)
		{
			var queryContainer = FindQuery(new QuerySearchModel { Message = message, Field = fieldName });
			queryContainer.Dropdowns()[0].SelectByText("Close Query");
		
			return this;
		}

		public CRFPage CancelQuery(string message, string fieldName)
		{
			var queryContainer = FindQuery(new QuerySearchModel { Message = message, Field = fieldName });
			queryContainer.Checkboxes()[0].Check();
		
			return this;
		}

		#endregion

		public override string URL { get { return "Modules/EDC/CRFPage.aspx"; } }
		
	}
}
