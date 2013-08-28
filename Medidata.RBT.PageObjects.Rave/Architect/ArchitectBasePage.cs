using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using TechTalk.SpecFlow;
namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class ArchitectBasePage : RavePageBase
	{
        /// <summary>
        /// Helper method to find the tr corresponding the architect field variable based on field setting name
        /// </summary>
        /// <param name="settingName">Name of the architect field setting</param>
        /// <returns></returns>
        protected IWebElement TryFindTrByFieldSettingName(string settingName)
        {
            IWebElement elem = Browser.TryFindElementsBy(By.XPath("//tr")).FirstOrDefault(e => e.Text.StartsWith(settingName));
            return elem;
        }
	}
}
