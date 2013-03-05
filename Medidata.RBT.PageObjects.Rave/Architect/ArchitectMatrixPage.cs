using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using Medidata.RBT.PageObjects.Rave.AmendmentManager;
namespace Medidata.RBT.PageObjects.Rave
{
	public class ArchitectMatrixPage : ArchitectBasePage
	{
		public override string URL
		{
			get
			{
                return "Modules/Architect/Matrices.aspx";
			}
		}

        public override IPage ClickLink(string linkText, string objectType = null, string areaIdentifier = null, bool partial = false)
        {
            if (linkText.Equals("Folder Forms"))
            {
                IWebElement matrixGrid = Browser.TryFindElementByPartialID("MatrixGrid");
                IWebElement folderFormsLink = matrixGrid.TryFindElementByXPath(".//tr/td[2][contains(text(),'" + areaIdentifier + "')]/../td[8]/a");
                folderFormsLink.Click();
                return WaitForPageLoads();
            }
            return base.ClickLink(linkText, objectType, areaIdentifier, partial);
        }
    }
}
