using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class FieldModel
	{
		public string Field { set; get; }
		public string Data { set; get; }
		public string ControlType { get; set; }
        public string FieldEditCheck { get; set; }
        public string High { set; get; }
        public string Low { set; get; }
        public bool? RequiresVerification { set; get; }
        public bool? Inactive { set; get; }
        public bool? RequiresSignature { get; set; }
	}
}
