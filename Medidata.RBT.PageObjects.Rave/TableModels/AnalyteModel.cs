using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// This model is to configure Analyte settings
    /// </summary>
    public class AnalyteModel
    {
        /// <summary>
        /// Name to be used to create Analyte
        /// </summary>
        public string AnalyteName { get; set; }

        /// <summary>
        /// Lab Unit Dictionary linked to the Analyte
        /// </summary>
        public string LabUnitDictionaryName { get; set; }
    }
}
