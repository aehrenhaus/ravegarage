﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave
{
	public class CompositeDropdown:ControlBase, IControl
	{
		public CompositeDropdown(IPage page, string name, IWebElement wrapper)
			: base(page)
		{
			this.wrapper = wrapper;
			this.Name = name;
		}

		public string Name;
		private IWebElement wrapper;

		public void TypeAndSelect(string text)
		{
			//first type ,then choose will limite the count of options.
			Type(text);
			//IF type first, then do not need to click the dropdown button.
			//IF click, what you entered will not be the filter
			//IWebElement dropdownButton = field.TryFindElementBy(By.XPath("./span/input[position()=2]"));
			//dropdownButton.Click();

			var option = Page.Browser.TryFindElementBy(
				driver => wrapper.FindElements(By.XPath("./div[position()=2]/div")).FirstOrDefault(x => x.Text.Contains( text))
				);

            if(option != null)
			    option.Click();
		}

		public void OpenWithinTime(int seconds)
		{
			var option = Page.Browser.TryFindElementBy(
				driver => wrapper.FindElements(By.XPath("./div[position()=2]/div")).FirstOrDefault(x => true), true, seconds);

		}


		public void Type(string text)
		{
			var input = wrapper.TryFindElementBy(By.XPath("./span/input[position()=1]")).EnhanceAs<Textbox>();
			input.SetText(text);
		}
	
	}
}
