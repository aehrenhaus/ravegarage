using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class CoderWorkFlowData
	{
		public int ID { get; set; }
		public int WorkFlowID { get; set; }
		public string WorkFlowKey { get; set; }
		public string WorkFlowDefaultValue { get; set; }
		public DateTime Created { get; set; }
		public DateTime Updated { get; set; }
	}
}
