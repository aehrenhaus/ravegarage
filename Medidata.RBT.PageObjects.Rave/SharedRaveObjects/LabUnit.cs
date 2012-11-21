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
    ///This is a rave specific LabUnit. It is seedable via the UI.
    ///</summary>
    public class LabUnit : BaseRaveSeedableObject
    {
        /// <summary>
        /// The Lab Unit constructor
        /// </summary>
        /// <param name="labUnitName">The feature file lab unit name</param>
        public LabUnit(string labUnitName)
        {
            UniqueName = labUnitName;
            SuppressSeeding = true;
        }
    }
}