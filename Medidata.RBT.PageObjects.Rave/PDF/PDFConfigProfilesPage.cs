using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SeleniumExtension;

namespace Medidata.RBT.PageObjects.Rave.PDF
{
    /// <summary>
    /// PDFConfigProfilesPage object to manage Rave pdf configuration
    /// related functionality
    /// </summary>
    class PDFConfigProfilesPage : RavePageBase
    {
        /// <summary>
        /// url for pdf config profiles page
        /// </summary>
        public override string URL
        {
            get
            {
                return "Modules/Configuration/PDFConfigProfiles.aspx";
            }
        }

        /// <summary>
        /// Adds the new pdf profile with named passed to profileName parameter
        /// </summary>
        /// <param name="profileName"></param>
        public void CreateNewPdfProfile(string profileName)
        {
            this.ClickLink("Add New");

            Textbox profileNameBox = Browser.TryFindElementById("_ctl0_Content_NewProfileDescription").
                EnhanceAs<Textbox>();
            profileNameBox.SetText(profileName);

            this.ClickLink("Save");
        }
    }
}
