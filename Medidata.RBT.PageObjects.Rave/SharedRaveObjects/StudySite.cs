using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Used when making study assignments on the user assignment page
    /// </summary>
    public class StudySite
    {
        public string ProjectName { get; set; }
		public string SiteName { get; set; }
		public string Environment { get; set; }
		public StudySite(string projectName, string siteName, string envr)
        {
            ProjectName = projectName;
            SiteName = siteName;
			Environment = envr;
        }

		public override bool Equals(object obj)
		{
			StudySite b = obj as StudySite;
			if (obj == null)
				return false;
			return b.ProjectName == this.ProjectName && b.Environment == this.Environment && b.SiteName == this.SiteName;
		}

        public override int GetHashCode()
        {
            return this.ToString().GetHashCode();
        }

		public override string ToString()
		{
			return string.Format("{0} - {1} ({2})", SiteName, ProjectName,Environment);
		}
    }
}
