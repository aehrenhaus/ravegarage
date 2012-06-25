using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using TechTalk.SpecFlow;

namespace Medidata.RBT.PageObjects.Rave
{
	public class FileRequestPage : RavePageBase
	{
		public FileRequestCreateDataRequestPage CreateDataPDF(Table table)
		{

			return new FileRequestCreateDataRequestPage();
		}
	}
}
