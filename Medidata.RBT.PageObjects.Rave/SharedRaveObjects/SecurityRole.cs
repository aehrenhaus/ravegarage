using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using Medidata.RBT.SharedRaveObjects;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// This is a rave specific SecurityRole.
    /// </summary>
	public class SecurityRole : BaseRaveSeedableObject
    {
               /// <summary>
        /// Create a SecurityRole if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="securityRoleName">Feature defined name of the SecurityRole</param>
        public SecurityRole(string securityRoleName)
        {
			UniqueName = securityRoleName;
			SuppressSeeding = true;
        }
    }
}