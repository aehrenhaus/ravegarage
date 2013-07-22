using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SharedObjects;
using System.Reflection;
using System.IO;
using System.Net;
using Medidata.RBT.Helpers;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    public abstract class RWSSeededGetObject : RWSSeededObject
    {
        protected RWSSeededGetObject()
        {
            WebRequestMethod = "GET";
        }
    }
}
