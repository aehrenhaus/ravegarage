using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace Medidata.RBT.PageObjects.Rave
{
    public class ReportsPage : RavePageBase
	{
		public ReportsPage(){
			
		}

        public PromptsPage SelectReport(string reportName)
        {

            return new PromptsPage();         
        }
          
	
	}
}
