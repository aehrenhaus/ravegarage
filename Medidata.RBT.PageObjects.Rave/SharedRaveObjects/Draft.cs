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
using Medidata.RBT.PageObjects.Rave.SiteAdministration;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Draft.
    ///</summary>
    public class Draft : IFeatureObject
    {
        public Guid? UID { get; set; }
        public string Name { get; set; }

        /// <summary>
        /// Create a Draft if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="draftName">Feature defined name of the draft</param>
        public Draft(string draftName)
        {
            if (!UID.HasValue)
            {
                UID = Guid.NewGuid();
                Name = draftName;
            }
        }
    }
}
