using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.EDC.Models
{
    /// <summary>
    /// The model used to code a data point
    /// </summary>
    public class CodeDataPointModel
    {
        public string Project { get; set; }
        public string Subject { get; set; }
        public string Field { get; set; }
        public string UncodedData { get; set; }
        public string CodedData { get; set; }
        public string CodingDictionary { get; set; }
        public string CodingDictionaryVersion { get; set; }
        public string CurrentUser { get; set; }
    }
}
