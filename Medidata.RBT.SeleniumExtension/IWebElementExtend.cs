using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using System.Collections.ObjectModel;
using TechTalk.SpecFlow;
using OpenQA.Selenium.Internal;

namespace Medidata.RBT.SeleniumExtension
{
	public static class IWebElementExtend
	{

		public static T EnhanceAs<T>(this IWebElement ele) where T : EnhancedElement, new() 
		{
			if (ele is T)
				return ele as T;

			return new T().SetComponent<T>(ele);
		}
			

	}
}
