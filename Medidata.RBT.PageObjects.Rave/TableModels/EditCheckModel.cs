using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    public class EditCheckModel
    {
        public string Name { set; get; }
        public bool BypassDuringMigration { set; get; }
        public bool Active { set; get; }
    }
}