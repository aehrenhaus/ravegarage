using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;


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
		public CRFPage OpenLogLine(int lineNum)
		{
			var editButtons = Browser.FindElements(
				By.XPath("//table[@id='log']//input[@src='../../Img/i_pen.gif']"));
			editButtons[lineNum-1].Click();
			return this;
		}

		public CRFPage ClickModify()
		{
			IWebElement editButton = Browser.TryFindElementById("_ctl0_Content_R_header_SG_PencilButton");
			editButton.Click();
			return this;
		}


		public CRFPage SaveForm()
		{
			IWebElement saveButton = Browser.TryFindElementById("_ctl0_Content_R_footer_SB");
			saveButton.Click();
			return this;
		}

        public bool CanFindQueryMessage(string fieldName, string message)
        {
           var dpLeftTd =  RavePagesHelper.GetDatapointLabelContainer(fieldName);
           return dpLeftTd.Text.IndexOf(message) != -1;
        }
	}
}
