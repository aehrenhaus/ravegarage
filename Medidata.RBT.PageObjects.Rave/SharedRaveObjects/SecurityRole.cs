﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
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
    public class SecurityRole : IFeatureObject
    {
        public Guid? UID { get; set; }
        public string Name { get; set; }
        private string m_UniqueName;
        private static bool m_EnableSeeding = RBTConfiguration.Default.EnableSeeding;
        public bool EnableSeeding()
        {
            return m_EnableSeeding;
        }
        public string UniqueName
        {
            get
            {
                if (m_EnableSeeding)
                    return m_UniqueName;
                else
                    return Name;
            }
            set { m_UniqueName = value; }
        }

        /// <summary>
        /// Create a SecurityRole if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="securityRoleName">Feature defined name of the SecurityRole</param>
        public SecurityRole(string securityRoleName)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = securityRoleName;
                UniqueName = securityRoleName;
            }
        }
    }
}