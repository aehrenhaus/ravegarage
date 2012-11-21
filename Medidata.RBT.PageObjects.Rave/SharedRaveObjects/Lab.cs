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
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.Lab;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Lab.
    ///</summary>
    public class Lab : BaseRaveSeedableObject
    {
        /// <summary>
        /// The Lab constructor
        /// </summary>
        /// <param name="analyteName">The feature file lab name</param>
        public Lab(string analyteName)
        {
            UniqueName = analyteName;
        }
    }
}