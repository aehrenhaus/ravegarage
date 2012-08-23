using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class LabRangeModel
	{
        public string Field { get; set; }
        public string Data  { get; set; }
        public string Range { get; set; }
        public string Unit  { get; set; }
        public string StatusIcon { get; set; }
        public string RangeStatus { get; set; }
	}
}
