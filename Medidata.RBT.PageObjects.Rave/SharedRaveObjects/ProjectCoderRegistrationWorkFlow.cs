using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class ProjectCoderRegistrationWorkFlow
	{
		public int ProjectCoderRegistrationWorkFlowID { get; set; }
		public int ProjectCoderRegistrationID { get; set; }
		public int WorkFlowID { get; set; }
		public bool DefaultWorkFlow { get; set; }
		public DateTime Created { get; set; }
		public DateTime Updated { get; set; }

		public CoderWorkFlow CoderWorkFlow { get; set; }
	}
}
