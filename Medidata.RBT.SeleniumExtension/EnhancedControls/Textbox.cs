using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SeleniumExtension
{
	public class Textbox :EnhancedElement
	{
		public Textbox()
		{
		}

		public void SetText(string text)
		{
			this.Clear();
			this.SendKeys(text);
		}


	}
}
