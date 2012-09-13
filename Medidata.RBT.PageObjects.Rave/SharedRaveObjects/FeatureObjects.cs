using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// FeatureObjects contains all of the Dictionaries of objects that exist during the course of a feature run. 
    /// At the end of the feature file, these Dictionaries are automatically cleared.
    /// </summary>
    public static class FeatureObjects
    {
        /// <summary>
        /// This constructor news up the dictionaries so that you do not get null references when referring to these dictionaries.
        /// </summary>
        static FeatureObjects()
        {
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, UploadedDraft>>("FeatureUploadDrafts", new Dictionary<string, UploadedDraft>());
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, CrfVersion>>("FeatureCrfVersions", new Dictionary<string, CrfVersion>());
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, User>>("FeatureUsers", new Dictionary<string, User>());
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, Role>>("FeatureRoles", new Dictionary<string, Role>());
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, Site>>("FeatureSites", new Dictionary<string, Site>());
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, Project>>("FeatureProjects", new Dictionary<string, Project>());
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, Draft>>("FeatureDrafts", new Dictionary<string, Draft>());
            Medidata.RBT.TestContext.SetFeatureContextValue<Dictionary<string, SecurityRole>>("FeatureSecurityRoles", new Dictionary<string, SecurityRole>());
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the UploadDraft object created by the UploadDraft constructor.
        /// </summary>
        public static Dictionary<string, UploadedDraft> UploadDrafts
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, UploadedDraft>>("FeatureUploadDrafts");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureUploadDrafts", value);
            }
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the CrfVersion object created by the CrfVersion constructor.
        /// </summary>
        public static Dictionary<string, CrfVersion> CrfVersions
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, CrfVersion>>("FeatureCrfVersions");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureCrfVersions", value);
            }
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the User object created by the User constructor.
        /// </summary>
        public static Dictionary<string, User> Users
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, User>>("FeatureUsers");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureUsers", value);
            }
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the Role object created by the Role constructor.
        /// </summary>
        public static Dictionary<string, Role> Roles
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, Role>>("FeatureRoles");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureRoles", value);
            }
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the SecurityRole object created by the SecurityRole constructor.
        /// </summary>
        public static Dictionary<string, SecurityRole> SecurityRoles
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, SecurityRole>>("FeatureSecurityRoles");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureSecurityRoles", value);
            }
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the Site object created by the Site constructor.
        /// </summary>
        public static Dictionary<string, Site> Sites
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, Site>>("FeatureSites");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureSites", value);
            }
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the Project object created by the Project constructor.
        /// </summary>
        public static Dictionary<string, Project> Projects
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, Project>>("FeatureProjects");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureProjects", value);
            }
        }

        /// <summary>
        /// Mapping of the name provided in the feature file to the Draft object created by the Draft constructor.
        /// </summary>
        public static Dictionary<string, Draft> Drafts
        {
            get
            {
                return Medidata.RBT.TestContext.GetFeatureContextValue<Dictionary<string, Draft>>("FeatureDrafts");
            }
            set
            {
                Medidata.RBT.TestContext.SetFeatureContextValue("FeatureDrafts", value);
            }
        }
    }
}
