using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class QuerySearchModel
	{
		public string Field { set; get; }
		public string QueryMessage { set; get; }

		public bool? Response { set; get; }
		public bool? ManualClose { set; get; }
		public bool? Closed { set; get; }
		public bool? Answered { set; get; }
		public string Answer { set; get; }
	}
}
