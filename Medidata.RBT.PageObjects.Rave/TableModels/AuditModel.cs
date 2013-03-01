using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class AuditModel
	{
		public string AuditType { set; get; }
        public string Audit { set; get; }
		public string QueryMessage { set; get; }
        public string User { set; get; }
        public string Time { set; get; }
	}
}
