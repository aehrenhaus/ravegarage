using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    public class GeneralPage : PageBase
    {
		public GeneralPage(WebTestContext context)
			: base(context)
		{
		}

        public override string URL
        {
            get { throw new NotImplementedException(); }
        }
    }
}
