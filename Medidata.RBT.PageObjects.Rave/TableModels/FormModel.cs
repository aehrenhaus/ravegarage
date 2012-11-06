using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class FormModel
	{
        public string Form { set; get; }
        public bool? RequiresReview { set; get; }
        public bool? Checked { set; get; }
	}
}
