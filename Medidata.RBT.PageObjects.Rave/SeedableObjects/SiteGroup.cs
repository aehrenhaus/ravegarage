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
using System.Xml.Linq;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    ///This is a rave specific Site. It is seedable.
    ///These are not uploaded, and are created entirely through the UI.
    ///</summary>
    public class SiteGroup : RWSSeededPostObject
    {
        public UploadedDraft Draft { get; set; }
        public string Number { get; set; }
        public string Group { get; set; }
        public List<Guid> StudyUIDs { get; set; }
        public int ID { get; set; }

        /// <summary>
        /// The Site constructor
        /// </summary>
        /// <param name="siteGroupName">The feature defined name of the Site Group</param>
        public SiteGroup(string siteGroupName)
            : base()
        {
            UniqueName = siteGroupName;
            Number = Guid.NewGuid().ToString();
        }

        protected override void SetBodyData()
        {
            XElement siteGroupXElement = new XElement("siteGroup");
            siteGroupXElement.Add(new XElement("siteGroupName") { Value = UniqueName });
            siteGroupXElement.Add(new XElement("siteGroupNumber") { Value = Number });

            BodyData = siteGroupXElement.ToString();
        }

        protected override void SetRaveWebServicesURL()
        {
            RaveWebServicesUrl = RaveConfigurationGroup.Default.RWSURL + "private/sitegroups/create";
        }

        protected override void TakeActionAsAResultOfRWSCall()
        {
            StreamReader sr = new StreamReader(WebResponse.GetResponseStream());
            int siteGroupID = -1;
            if (Int32.TryParse(sr.ReadToEnd(), out siteGroupID))
                ID = siteGroupID;
            else
                throw new Exception("Could not create SiteGroup.");
        }
    }
}