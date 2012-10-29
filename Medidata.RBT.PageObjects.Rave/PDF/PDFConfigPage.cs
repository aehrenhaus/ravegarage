using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.PDF
{
    public class PDFConfigPage : RavePageBase
    {
        public IPage SelectAnnotation(string annotationName)
        {
            this.ClickLink("Annotations");
            return this.ChooseFromCheckboxes("Content_PDFConfigForm_" + annotationName, true);
        }

        public IPage SaveSettings()
        {
            return this.ClickLink("Save");
        }

        /// <summary>
        /// url for pdf config page
        /// </summary>
        public override string URL
        {
            get
            {
                return "Modules/Configuration/PDFConfig.aspx";
            }
        }
    }
}
