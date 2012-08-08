using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Collections.Specialized;

namespace Medidata.RBT.PageObjects.Rave
{
	public interface IEDCFieldControl : IControl
	{
		AuditsPage ClickAudit();

		void EnterData(string text, ControlType controlType);

		IWebElement FindQuery(QuerySearchModel filter);

		void AnswerQuery(QuerySearchModel filter);

		void CloseQuery(QuerySearchModel filter);

		void CancelQuery(QuerySearchModel filter);

		void Check(string checkName);

		void Uncheck(string checkName);
	}
}
