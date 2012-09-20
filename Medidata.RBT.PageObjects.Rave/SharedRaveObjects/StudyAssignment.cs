using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Used when making study assignments on the user assignment page
    /// </summary>
    public class StudyAssignment
    {
        public Guid ProjectUID { get; set; }
        public Guid RoleUID { get; set; }
        public Guid SiteUID { get; set; }

        public StudyAssignment(Guid projectUID, Guid roleUID, Guid siteUID)
        {
            ProjectUID = projectUID;
            RoleUID = roleUID;
            SiteUID = siteUID;
        }
    }
}
