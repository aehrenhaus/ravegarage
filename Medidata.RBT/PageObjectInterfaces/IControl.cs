using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	public interface IControl
	{
		IPage Page { get; }
		IWebElement Element { get; }

	}
}
