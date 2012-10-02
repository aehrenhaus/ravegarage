using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class AnalyteRangeModel
	{
        public string Analyte { get; set; }
        public string FromDate  { get; set; }
        public string ToDate { get; set; }
        public string FromAge  { get; set; }
        public string ToAge { get; set; }
        public string Sex { get; set; }
        public string LowValue { get; set; }
        public string HighValue { get; set; }
        public string Units { get; set; }
        public string Dictionary { get; set; }
        public string Comments { get; set; }
        public string Edit { get; set; }
        public bool NewVersion { get; set; }
	}
}
