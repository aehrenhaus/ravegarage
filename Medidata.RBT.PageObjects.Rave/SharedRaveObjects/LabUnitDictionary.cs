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

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific LabUnitDictionary. It is seedable via the UI.
    ///</summary>
    public class LabUnitDictionary : BaseRaveSeedableObject
    {
        /// <summary>
        /// The Lab Unit Dictionary constructor
        /// </summary>
        /// <param name="labUnitDictionaryName">The feature file lab unit dictionary name</param>
        public LabUnitDictionary(string labUnitDictionaryName)
        {
            UniqueName = labUnitDictionaryName;
            SuppressSeeding = true;
        }
    }
}