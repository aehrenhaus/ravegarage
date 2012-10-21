using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    public class EmptyPage : PageBase
    {
        public override string URL
        {
            get { throw new NotImplementedException(); }
        }
    }
}
