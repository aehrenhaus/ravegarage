using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	public  class CRFPage : BaseEDCTreePage
	{
        private Checkbox GetQueryCancelCheckbox(string message, string fieldName)
        {
            var fieldArea = RavePagesHelper.GetDatapointLabelContainer(fieldName);
            var queryTable = fieldArea.FindElements(
                By.XPath(".//td[@class='crf_preText']/table"));
            foreach (var table in queryTable)
            {
                if (table.Text.IndexOf(message) != -1)
                {
					return table.Checkboxes()[0];
                }
            }
            return null;
        }


        public CRFPage CancelQuery(string message, string fieldName)
        {
            var queryCancelCheckbox = GetQueryCancelCheckbox(message, fieldName);
            if (queryCancelCheckbox == null)
                throw new Exception(String.Format("Query cancel checkbox not found for message: {0}, field: {1}", message, fieldName));

            queryCancelCheckbox.Check();
            return this;
        }

		public CRFPage FillDataPoint(string label, string val)
		{
			RavePagesHelper.FillDataPoint(label, val);
			return this;
		}

        private Textbox GetQueryResponseTextbox(string message, string fieldName)
        {
            var fieldArea = RavePagesHelper.GetDatapointLabelContainer(fieldName);
            var queryTable = fieldArea.FindElements(
                By.XPath(".//td[@class='crf_preText']/table"));
            foreach (var table in queryTable)
            {
                if (table.Text.IndexOf(message) != -1)
                {
					return table.Textboxes()[0];
                }
            }
            return null;
        }


        private bool QueryWithNoRequiresResponseExists(string message, string fieldName)
        {
            var fieldArea = RavePagesHelper.GetDatapointLabelContainer(fieldName);
            var queryTable = fieldArea.FindElements(
                By.XPath(".//td[@class='crf_preText']/table"));
            foreach (var table in queryTable)
            {
                if (table.Text.IndexOf(message) != -1)
                {
                    if (table.Textboxes().Count == 0)
                        return true;
                    else
                        return false;
                }
            }
            return false ;
        }

        public CRFPage AnswerQuery(string message, string fieldName, string answer)
        {
            var queryTextbox = GetQueryResponseTextbox(message, fieldName);
            if (queryTextbox == null)
                throw new Exception(String.Format("Query textbox not found for message: {0}, field: {1}", message, fieldName));

			queryTextbox.EnhanceAs<Textbox>().SetText(answer);
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

        public bool CanFindQueryMessage(string fieldName, string message)
        {
           var dpLeftTd =  RavePagesHelper.GetDatapointLabelContainer(fieldName);
           return dpLeftTd.Text.IndexOf(message) != -1;
        }

        public bool QueryExistOnField(string fieldName)
        {
            var fieldArea = RavePagesHelper.GetDatapointLabelContainer(fieldName);
            var queryTable = fieldArea.FindElements(
                By.XPath(".//td[@class='crf_preText']/table"));
            return queryTable.Count > 0; 
        }

        public bool CanFindQueryRequiringResponse(string fieldName, string message)
        {
            return (GetQueryResponseTextbox(message, fieldName) != null);
        }

        public bool CanFindQueryNotRequiringResponse(string fieldName, string message)
        {
            return (QueryWithNoRequiresResponseExists(message, fieldName));
        }
        
	}
}
