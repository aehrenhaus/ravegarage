using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.Configuration.Models;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class CoderConfigurationPage : ConfigurationBasePage, IVerifySomethingExists
    {
        public void FillData(IEnumerable<CoderConfigurationModel> createSet)
        {
            var coderConfigurationModel = createSet as List<CoderConfigurationModel> ?? createSet.ToList();
            if (coderConfigurationModel.Count()!=1) throw new ArgumentException("Invalid number of arguments");

            CoderConfigurationModel model = coderConfigurationModel.First();
            base.ChooseFromDropdown("_ctl0_Content_coderMarkingGroup", model.ReviewMarkingGroup);

			base.ChooseFromCheckboxes("_ctl0_Content_chkReqResponse", model.RequiresResponse == "True");
        }

        public IPage Save()
        {
            return this.ClickLink("Update");
        }

        public override string URL
        {
            get { return "Modules/Configuration/CoderConfiguration.aspx"; }
        }

		public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false)
		{
		
			if (identifier == "Requires Response checked")
			{
				var checkbox = Browser.CheckboxByID("_ctl0_Content_chkReqResponse");
				return checkbox.Checked;
			} 
			
			if (identifier == "Requires Response unchecked")
			{
				var checkbox = Browser.CheckboxByID("_ctl0_Content_chkReqResponse");
				return !checkbox.Checked;
			}
			

			if (areaIdentifier == "Review Marking Group dropdown")
			{
				var dropdown = Browser.DropdownById("_ctl0_Content_coderMarkingGroup");

				return dropdown.SelectedText == identifier;
			}

			return false;
		}
    }
}
