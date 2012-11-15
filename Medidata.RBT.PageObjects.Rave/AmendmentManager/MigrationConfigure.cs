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
    public class MigrationConfigurePage : RavePageBase
	{

		public override string URL
		{
			get
			{
                return "Modules/AmendmentManager/MigrationConfigure.aspx";
			}
		}

        public override IPage ChooseFromCheckboxes(string identifier, bool isChecked, string areaIdentifier = null, string listItem = null)
        {
            identifier = (identifier == "Field visibility changed") ? "chkFieldVisibilityChange" : "";
            base.ChooseFromCheckboxes(identifier, isChecked, areaIdentifier, listItem);
            return this;
        }

	}
}
