using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.Audits
{
    /// <summary>
    /// The object can verify audits exist
    /// </summary>
    public interface IVerifyAudits
    {
        bool AuditExist(string message, string user, string timeFormat, int? position = null);
    }
}
