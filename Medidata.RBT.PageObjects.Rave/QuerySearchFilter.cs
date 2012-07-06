using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class QuerySearchFilter
	{
		public string Field { set; get; }
		public string Message { set; get; }
		public bool? RR { set; get; }
		public bool? RC { set; get; }
		public bool? Closed { set; get; }
		
	}
}
