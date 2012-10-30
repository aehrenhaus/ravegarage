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
        public string ProjectName { get; set; }
		public string RoleName { get; set; }
		public string SiteName { get; set; }

		public StudyAssignment(string projectName, string roleName, string siteName)
        {
            ProjectName = projectName;
            RoleName = roleName;
            SiteName = siteName;
        }
    }
}
