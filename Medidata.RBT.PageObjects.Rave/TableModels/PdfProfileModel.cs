using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    /// <summary>
    /// This model is to configure pdf settings
    /// </summary>
    public class PdfProfileModel
    {
        /// <summary>
        /// Name to be used to create pdf
        /// </summary>
        public string ProfileName { get; set; }
        /// <summary>
        /// Annotation to be selected for pdf
        /// </summary>
        public string Annotation { get; set; }
    }
}
