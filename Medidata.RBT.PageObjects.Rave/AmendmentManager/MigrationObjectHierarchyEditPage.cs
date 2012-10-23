using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using Medidata.RBT.SeleniumExtension;
using System.Threading;
namespace Medidata.RBT.PageObjects.Rave.AmendmentManager
{
    public class MigrationObjectHierarchyEditPage : RavePageBase
	{
        public override IWebElement GetElementByName(string identifier, string areaIdentifier = null, string listItem = null)
        {
            if(identifier=="Action")
            {
                return Browser.TryFindElementByPartialID("SelectCommand");
            }
            return base.GetElementByName(identifier, areaIdentifier, listItem);
        }

		public override string URL
		{
			get
			{
                return "Modules/AmendmentManager/MigrationObjectHierarchyEdit.aspx";
			}
		}

	}
}
