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

        /// <summary>
        /// Set the text in a textbox
        /// </summary>
        /// <param name="text">The text to put in the textbox</param>
		public void SetText(string text)
		{
			this.Clear();
			this.SendKeys(text);
		}
	}
}
