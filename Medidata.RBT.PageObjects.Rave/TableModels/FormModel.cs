using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    /// <summary>
    /// This model serves double duty for landscape log forms and verifying form status icon
    /// </summary>
	public class FormModel
	{
        public string Form { set; get; }
        public int? Record { set; get; }
        public string StatusIcon { set; get; }
        public bool? Checked { set; get; }
	}
}
