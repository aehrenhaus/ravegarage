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
    public class MigrationObjectHierarchyPage : RavePageBase
	{

		public override string URL
		{
			get
			{
                return "Modules/AmendmentManager/MigrationObjectHierarchy.aspx";
			}
		}

	}
}
