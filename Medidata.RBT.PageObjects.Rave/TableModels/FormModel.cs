using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    /// <summary>
    /// This model verifies status icon on a form
    /// </summary>
	public class FormModel
	{
        public string Form { set; get; }
        public string StatusIcon { set; get; }
        public bool? Checked { set; get; }
	}
}
