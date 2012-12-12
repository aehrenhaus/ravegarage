using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT
{
	public interface ICanDisableEnable
	{
		void Disable(string type, string identifier);

		void Enable(string type, string identifier);
	}
}
