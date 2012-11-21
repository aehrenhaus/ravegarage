using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// This model is to configure LabUnitDictionary settings
    /// </summary>
    public class LabUnitDictionaryModel
    {
        /// <summary>
        /// Name to be used to create LabUnitDictionary
        /// </summary>
        public string LabUnitDictionaryName { get; set; }

        /// <summary>
        /// Lab Unit linked to the lab unit dictionary
        /// </summary>
        public string LabUnitName { get; set; }
    }
}
