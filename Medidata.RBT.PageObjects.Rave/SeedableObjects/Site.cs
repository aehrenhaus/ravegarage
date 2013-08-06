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
using System.Net;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Web;
using Medidata.RBT.Helpers;
using System.Xml.Linq;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    ///This is a rave specific Site. It is seedable.
    ///These are not uploaded, and are created entirely through the UI.
    ///</summary>
    public class Site : RWSSeededPostObject
    {
        public int ID { get; set; }
        public UploadedDraft Draft { get; set; }
        public string Number { get; set; }
        public SiteGroup SiteGroup { get; set; }
        public List<SharedRaveObjects.StudySite> StudySites { get; set; }
        public bool Active { get; set; }

        /// <summary>
        /// The Site constructor
        /// </summary>
        /// <param name="siteName">The feature defined name of the Site. </param>
        /// <param name="siteGroup">Name of site group. Creates one with the name defaultSiteGroup+TID if none is specified</param>
        /// <param name="siteNumber">The number of the site</param>
        public Site(string siteName, string siteGroup = "defaultSiteGroup", string siteNumber = null, bool uploadAfterMakingUnique = true)
            : base(uploadAfterMakingUnique)
        {
            PartialRaveWebServiceUrl = "private/sites/create";
            UniqueName = siteName;
            Number = siteNumber ?? Guid.NewGuid().ToString();
            SiteGroup = SeedingContext.GetExistingFeatureObjectOrMakeNew<SiteGroup>(siteGroup, () => new SiteGroup(siteGroup));
            StudySites = new List<SharedRaveObjects.StudySite>();
            Active = true;
        }

        protected override void SetBodyData()
        {
            XElement siteXElement = new XElement("site");
            siteXElement.Add(new XElement("siteName") { Value = UniqueName });
            siteXElement.Add(new XElement("siteNumber") { Value = Number });
            siteXElement.Add(new XElement("siteGroupID") { Value = SiteGroup.ID.ToString() });
            siteXElement.Add(new XElement("active") { Value = Active.ToString() });

            BodyData = Encoding.UTF8.GetBytes(siteXElement.ToString());
        }

        protected override void TakeActionAsAResultOfRWSCall()
        {
            StreamReader sr = new StreamReader(WebResponse.GetResponseStream());
            int siteID = -1;
            if (Int32.TryParse(sr.ReadToEnd(), out siteID))
                ID = siteID;
            else
                throw new Exception("Could not create Site.");
        }
    }
}