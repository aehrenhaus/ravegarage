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
    public abstract class RWSSeededPostObject : RWSSeededObject
	{
        protected RWSSeededPostObject()
        {
            WebRequestMethod = "POST";
            ContentType = "application/xml";
            ContentLength = 0;
        }

        public override void Seed()
        {
            base.Seed();
        }
	}
}
