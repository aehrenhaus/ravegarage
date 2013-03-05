using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class CoderWorkFlow
	{
		public int ID { get; set; }
		public string Name { get; set; }
		public DateTime Created { get; set; }
		public DateTime Updated { get; set; }
		public bool DefaultWorkFlow { get; set; }
		public int ExternalID { get; set; }

		public IList<CoderWorkFlowData> CoderWorkFlowData { get; private set; }

		public CoderWorkFlow()
		{
			this.CoderWorkFlowData = new List<CoderWorkFlowData>();
		}
	}
}
