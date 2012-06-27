using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;
using System.Collections.ObjectModel;
using System.Threading;
using Medidata.RBT.SeleniumExtension;


namespace Medidata.RBT.PageObjects.Rave
{
    public class PromptsPage : RavePageBase
	{
		public PromptsPage(string reportPOName)
		{
			this.reportPOName = reportPOName;
		}

		private string reportPOName;


		public override IPage ClickButton(string textOrName)
		{
			if (textOrName == "Submit Report")
			{
				base.ClickButton(textOrName);
				return RavePageObjectFactory.GetPage(reportPOName);
			}
			return base.ClickButton(textOrName);
		}



		public PromptsPage SetParameter(string name, Table table)
		{
			var paraTR = FindParameterTr(name);
			//wait till the div div becomes visible, that means the table is loaded complete
			var di = WaitForElement(x => paraTR.TryFindElementBy(By.XPath("./td[position()=2]/table/tbody/tr[position()=2]/td/div[@style='display: block;']")), "error",5);

			var tbl = paraTR.FindElements(By.XPath(".//td[@style='border-width:0px;border-collapse:collapse;']/table"))[1].EnhanceAs<HtmlTable>();

		//	Thread.Sleep(1000);
			var matchRows = tbl.FindMatchRows(table);
			foreach (var row in matchRows)
			{

				row.Checkboxes()[0].Click();
			}

			return this;
		}

		private IWebElement FindParameterTr(string name)
		{
			//TODO: paraTRs can be cached and reused during the life time of po???

			var paraTRs = Browser.FindElementsByXPath("/html/body/div[3]/div[2]/div/form/div/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr");
			var paraTR = paraTRs.FirstOrDefault(x => x.FindElement(By.XPath("./td")).Text == name + ":");

			//It's image button for some field, and img for other controls....
			var extendButton = paraTR
				.FindImagebuttons()
				.FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_small_right.gif"));
			if (extendButton == null)
				extendButton = paraTR
				.FindImages()
				.FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_small_right.gif"));
			
			extendButton.Click();

			return paraTR;
		}

		public PromptsPage SetParameter(string name, string value)
		{
			var paraTR = FindParameterTr(name);
			var textbox = paraTR.Textboxes()[0];

			if (textbox.GetAttribute("readonly") == "true")
			{
				//a datetime control
				textbox.RemoveAttribute("readonly");

				textbox.SetText(value);
				textbox.Click();
			}
			else
			{
				// a text box control

				textbox.SetText(value);
				//
				var checkButton = paraTR
					.FindImagebuttons()
					.FirstOrDefault(x => x.GetAttribute("src").EndsWith("Img/i_ccheck.gif"));

				checkButton.Click();
			}

	



			return this;
		}

	}
}
