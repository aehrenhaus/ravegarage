using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave.Configuration.Models;

namespace Medidata.RBT.PageObjects.Rave.Configuration
{
    public class CoderConfigurationPage : ConfigurationBasePage
    {
        public void FillData(IEnumerable<CoderConfigurationModel> createSet)
        {
            var coderConfigurationModel = createSet as List<CoderConfigurationModel> ?? createSet.ToList();
            if (coderConfigurationModel.Count()!=1) throw new ArgumentException("Invalid number of arguments");

            CoderConfigurationModel model = coderConfigurationModel.First();
            base.ChooseFromDropdown("_ctl0_Content_coderMarkingGroup", model.ReviewMarkingGroup);
            base.ChooseFromCheckboxes("_ctl0_Content_chkReqResponse", model.RequiresResponse == "True");
            base.ChooseFromCheckboxes("_ctl0_Content_chkReqManualClose", model.RequiresManualClose == "True");
        }

        public IPage Save()
        {
            return this.ClickLink("Update");
        }

        public override string URL
        {
            get { return "Modules/Configuration/CoderConfiguration.aspx"; }
        }
    }
}
