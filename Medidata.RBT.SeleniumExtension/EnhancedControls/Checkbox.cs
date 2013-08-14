using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using Medidata.RBT.SeleniumExtension.Exceptions;

namespace Medidata.RBT.SeleniumExtension
{
	public class Checkbox :EnhancedElement
	{
		public Checkbox()
		{
		}

		public Checkbox(IWebElement ele)
			: base(ele)
		{
		}

		public bool Checked
		{
			get
			{
				return Element.GetAttribute("checked") == "true";
			}
		}

		public void Check()
		{
            VerifyIfCheckBoxEnabled();
            if (!this.Selected)
                this.Click();
		}

		public void Uncheck()
		{
            VerifyIfCheckBoxEnabled();
            if (this.Selected)
                this.Click();
		}

		public void Toggle()
		{
              VerifyIfCheckBoxEnabled();
              this.Click();
           
		}
        private void VerifyIfCheckBoxEnabled()
        {
            if (!this.Enabled)
            {
                var parent = this.Parent();
                var message = String.Format("{'0'} is disabled", parent != null ? parent.Text : this.Id);
                throw new ControlDisabledException(message);
            }
        }
	}
}
