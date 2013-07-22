using System;
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
using Medidata.RBT.SharedObjects;
using Medidata.RBT.PageObjects.Rave.Lab;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    class StandardGroup : UniquedSeedableObject
    {
        /// <summary>
        /// The StandardGroup constructor
        /// </summary>
        /// <param name="analyteName">The feature file StandardGroup name</param>
        public StandardGroup(string standardGroupName)
        {
            UniqueName = standardGroupName;
        }
    }
}
