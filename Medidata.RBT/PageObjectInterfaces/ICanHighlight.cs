using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	public interface ICanHighlight
	{
		void Hightlight(string type, IWebElement eleToHighlight);
	}
}
