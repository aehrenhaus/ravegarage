﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using Medidata.RBT.Seeding;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.PageObjects.Rave.Configuration;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// This is a rave specific SecurityRole.
    /// </summary>
    public class SecurityRole
    {
        public Guid UID { get; set; }
        public string Name { get; set; }
        public string UniqueName { get; set; }

        /// <summary>
        /// Create a SecurityRole if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="securityRoleName">Feature defined name of the SecurityRole</param>
        public SecurityRole(string securityRoleName)
        {
            if (FeatureObjects.SecurityRoles != null && FeatureObjects.SecurityRoles.ContainsKey(securityRoleName))
            {
                SecurityRole securityRole = FeatureObjects.SecurityRoles[securityRoleName];
                UID = securityRole.UID;
                Name = securityRole.Name;
                UniqueName = securityRole.UniqueName;
            }
            else
            {
                UID = Guid.NewGuid();
                Name = securityRoleName;
                UniqueName = securityRoleName;
                FeatureObjects.SecurityRoles.Add(securityRoleName, this);
            }
        }
    }
}