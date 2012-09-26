using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Used when making module assignments on the user assignment page
    /// </summary>
    public class ModuleAssignment
    {
        public string ProjectName { get; set; }
        public string SecurityRole { get; set; }

        public ModuleAssignment(string projectName, string securityRole)
        {
            ProjectName = projectName;
            SecurityRole = securityRole;
        }
    }
}
