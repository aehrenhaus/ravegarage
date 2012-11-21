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
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.Lab;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Analyte. It is seedable via the UI.
    ///</summary>
    public class Analyte : BaseRaveSeedableObject
    {
        public string LabUnitDictionary { get; set; }

        /// <summary>
        /// The Analyte constructor
        /// </summary>
        /// <param name="analyteName">The feature file analyte name</param>
        public Analyte(string analyteName)
        {
            UniqueName = analyteName;
        }

        /// <summary>
        /// Create a unique name for the site by appending a TID.
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }
    }
}