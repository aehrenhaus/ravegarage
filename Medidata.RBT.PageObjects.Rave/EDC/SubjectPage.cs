using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.PageObjects.Rave
{
	public class SubjectPage : BaseEDCTreePage
	{
        public IWebElement GetTaskSummaryArea(string header)
		{
			var TRs = Browser.FindElementsByXPath("//span[@id='_ctl0_Content_TsBox_CBoxC']/table/tbody/tr[position()>1]");

			var TR = TRs.FirstOrDefault(x => x.Text.Contains(header));

			return TR;
		}

		public SubjectPage ExpandTask(string header)
		{
			var TR = GetTaskSummaryArea(header);

			var expandButton = TR.Images().FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_right.gif"));
			expandButton.Click();
			
			//wait for contents to load
			this.WaitForElement(driver => Browser.FindElementByXPath("//body[@style='cursor: default;']"));


			return this;
		}

		public override bool CanSeeTextInArea(string text, string areaName)
		{
			//TODO: this is just a simple version of finding text. Implement more useful version later
			var TR = GetTaskSummaryArea(areaName);

			return TR.Text.Contains(text);
		}


		public override IWebElement GetElementByName(string name)
		{
            IWebElement element;
            string id = "";

            if (name == "Add Event")
                id = "_ctl0_Content_SubjectAddEvent_MatrixList";
            else if (name == "Add")
                id = "_ctl0_Content_SubjectAddEvent_SaveBtn";
            else if (name == "Enable" || name == "Disable")
                id = "_ctl0_Content_SubjectAddEvent_LockAddEventSaveBtn";
            else if (name == "Set")
                id = "_ctl0_Content__ctl0_RadioButtons_0";
            else if (name == "Clear")
                id = "_ctl0_Content__ctl0_RadioButtons_1";
            else
			    return GetTaskSummaryArea(name);

            try
            {
                element = base.Browser.FindElementById(id);
            }
            catch
            {
                element = null;
            }

            return element;
		}

		//protected override IPage GetTargetPageObjectByLinkAreaName(string type, string areaName)
		//{
		//    //if (areaName == "")
		//    return TestContext.POFactory.GetPage("CRFPage");
		//}


		public override string GetInfomation(string identifer)
		{
			if (identifer == "crfversion")
				return GetCRFVersion();
			return base.GetInfomation(identifer);
		}

		public string GetCRFVersion()
		{
			var trs = Browser.Table("Table1").Children()[0].Children();
			var tr = trs[trs.Count - 1];
			var text = tr.Text.Trim();
			//CRF Version 1410 - Page Generated: 17 Jul 2012 10:00:25 FLE Daylight Time
			string version = text.Substring(11, text.IndexOf("-") -12).Trim();
			return version;
		}

		public override string URL
		{
			get
			{
				return "Modules/EDC/SubjectPage.aspx";
			}
		}
	}
}
