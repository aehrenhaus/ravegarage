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
		public PromptsPage()
		{
		}

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
				return TestContext.POFactory.GetPage(reportPOName);
			}
			return base.ClickButton(textOrName);
		}



		public PromptsPage SetParameter(string name, Table table)
		{
			var paraTR = FindParameterTr(name);
			//wait till the div div becomes visible, that means the table is loaded complete
			var div = this.WaitForElement(x => paraTR.TryFindElementBy(By.XPath("./td[position()=2]/table/tbody/tr[position()=2]/td/div[@style='display: block;']")),
				"timeout before div becomes visible");

			var tbl = paraTR.FindElements(By.XPath(".//td[@style='border-width:0px;border-collapse:collapse;']/table"))[1].EnhanceAs<HtmlTable>();

		//	Thread.Sleep(1000);
			var matchRows = tbl.FindMatchRows(table);
			if (matchRows.Count == 0)
				throw new Exception("Can't find matched options");
			foreach (var row in matchRows)
			{
				row.Checkboxes()[0].Click();
			}

			return this;
		}

		private IWebElement FindParameterTr(string name)
		{
			var paraTRs = Browser.FindElementsByXPath("/html/body/div[3]/div[2]/div/form/div/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr");
			var paraTR = paraTRs.FirstOrDefault(x => x.FindElement(By.XPath("./td")).Text == name + ":");

			if (paraTR == null)
				throw new Exception("Can not find argument block:"+name);

			//It's image button for some field, and img for other controls....
			var extendButton = paraTR
				.FindImagebuttons()
				.FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_small_right.gif"));
			if (extendButton == null)
				extendButton = paraTR
				.Images()
				.FirstOrDefault(x => x.GetAttribute("src").EndsWith("arrow_small_right.gif"));
			
			//may be already clicked 
			if(extendButton!=null)
				extendButton.Click();

			return paraTR;
		}

		public PromptsPage SearchInParameter(string name, string value)
		{			
			var paraTR = FindParameterTr(name);
			//wait till the div div becomes visible, that means the table is loaded complete
			var div = this.WaitForElement(x => paraTR.TryFindElementBy(By.XPath("./td[position()=2]/table/tbody/tr[position()=2]/td/div[@style='display: block;']")),
				"timeout before div becomes visible");

			var textbox = paraTR.Textbox("SearchTxt");
			textbox.SetText(value);
			var btnSearch = paraTR.TryFindElementByPartialID("SearchBtn");
			btnSearch.Click();
		
			this.WaitForElement(b =>
			{

				var working = paraTR.TryFindElementByPartialID("Working2");
				if (working.GetCssValue("display") == "none")
					return working;
				return null;
			}
				);
			return this;
		}

		public PromptsPage SetParameter(string name, string value)
		{
			var paraTR = FindParameterTr(name);
			var textbox = paraTR.Textboxes()[0];

			if (textbox.GetAttribute("readonly") == "true")
			{
				//a datetime control
				//This is a hack 
				//Because selecting a date from the calendar control is hard
				//I fill the textbox directly. And 'readonly' must be removed before setting the text
				textbox.Element.RemoveAttribute("readonly");

				textbox.SetText(value);
				textbox.Click();
				var div = paraTR.TryFindElementByPartialID("LabelDiv");
				div.SetInnerHtml(value);
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
