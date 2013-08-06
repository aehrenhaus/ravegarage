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
    /// <summary>
    /// All RWS objects which make calls via POST should inherit from this class
    /// </summary>
    public abstract class RWSSeededPostObject : RWSSeededObject
	{
        protected RWSSeededPostObject(bool uploadAfterMakingUnique = true)
            : base(uploadAfterMakingUnique)
        {
            WebRequestMethod = "POST";
            ContentType = "application/xml";
            ContentLength = 0;
        }
	}
}
