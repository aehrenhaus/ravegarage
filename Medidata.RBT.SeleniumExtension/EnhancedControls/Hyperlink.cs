using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SeleniumExtension
{
	public class Hyperlink :EnhancedElement
	{
		public Hyperlink()
		{
		}

		public string Href
		{
			get { return this.GetAttribute("href"); }
		}
	}
}
