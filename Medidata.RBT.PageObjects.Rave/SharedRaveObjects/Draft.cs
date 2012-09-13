using System;
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
using Medidata.RBT.PageObjects.Rave.SiteAdministration;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific Draft.
    ///</summary>
    public class Draft
    {
        public Guid UID { get; set; }
        public string Name { get; set; }

        /// <summary>
        /// Create a Draft if it is not already in the dictionary of projects in FeatureObject
        /// </summary>
        /// <param name="draftName">Feature defined name of the draft</param>
        public Draft(string draftName)
        {
            if (FeatureObjects.Drafts != null && FeatureObjects.Drafts.ContainsKey(draftName))
            {
                Draft draft = FeatureObjects.Drafts[draftName];
                UID = draft.UID;
                Name = draft.Name;
            }
            else
            {
                UID = Guid.NewGuid();
                Name = draftName;
                FeatureObjects.Drafts.Add(draftName, this);
            }
        }
    }
}
