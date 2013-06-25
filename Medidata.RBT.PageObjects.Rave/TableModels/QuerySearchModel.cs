using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class QuerySearchModel : ResponseSearchModel
	{
		public bool? Response { set; get; }
		public bool? ManualClose { set; get; }
		public bool? Closed { set; get; }
		public bool? Answered { set; get; }
		public string Answer { set; get; }
	}
}
