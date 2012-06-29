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
	public  class SubjectPage : BaseEDCTreePage
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

			return this;
		}

		public override bool CanSeeTextInArea(string text, string areaName)
		{
			//TODO: this is just a simple version of finding text. Implement more useful version later
			var TR = GetTaskSummaryArea(areaName);

			return TR.Text.Contains(text);
		}


		protected override IWebElement GetElementByName(string name)
		{
			var tr = GetTaskSummaryArea(name);
			return tr;
		}

		protected override IPage GetTargetPageObjectByLinkAreaName(string type, string areaName)
		{
			//if (areaName == "")
			return RavePageObjectFactory.GetPage("CRFPage");
		}
	}
}
