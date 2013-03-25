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

        public bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, RBT.BaseEnhancedPDF pdf = null, bool? bold = null)
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

            if (!string.IsNullOrWhiteSpace(type) && type.Equals("text", StringComparison.InvariantCultureIgnoreCase))
            {
                if (!exactMatch && Browser.PageSource.Contains(identifier))
                    return true;
            }

			return false;
		}

        public bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch, int? amountOfTimes, RBT.BaseEnhancedPDF pdf, bool? bold)
        {
            foreach (string identifier in identifiers)
                if (VerifySomethingExist(areaIdentifier, type, identifier, exactMatch, amountOfTimes, pdf, bold) == false)
                    return false;

            return true;
        }
    }
}
