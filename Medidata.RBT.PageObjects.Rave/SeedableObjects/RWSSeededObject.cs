using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.PageObjects.Rave;
using Medidata.RBT.SharedObjects;
using System.Reflection;
using System.IO;
using System.Net;
using Medidata.RBT.Helpers;
using Medidata.MAuth;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
	///<summary>
    ///All objects which can seed should implement this class. 
    ///The seedable objects should be marked for seeding when created.
    ///</summary>
    public abstract class RWSSeededObject : UniquedSeedableObject
	{
        protected const string UrlEncodedContentType = "application/x-www-form-urlencoded";
        public string WebRequestMethod { get; set; }
        public string ContentType { get; set; }
        public int? ContentLength { get; set; }
        protected WebResponse WebResponse { get; set; }
        protected string BodyData { get; set; }

        protected string RaveWebServicesUrl { get; set; }
        protected string PartialRaveWebServiceUrl { get; set; }

        public override void Seed()
        {
            base.Seed();
            if(WebRequestMethod == "POST")
                SetBodyData();
            SetRaveWebServicesURL();
            MakeRWSCall();
            TakeActionAsAResultOfRWSCall();
        }

        protected virtual void SetRaveWebServicesURL()
        {
            if (PartialRaveWebServiceUrl == null)
                throw new InvalidDataException("PartialRaveWebServiceUrl must be set in the object that inherits from RWSSeededObject.");

            RaveWebServicesUrl = string.Format("{0}{1}", RaveConfigurationGroup.Default.RWSURL, PartialRaveWebServiceUrl);
        }

        /// <summary>
        /// Create a unique version of the object, usually by uploading the object.
        /// </summary>
        protected virtual void MakeRWSCall()
        {
            WebRequest webRequest = MAuthHelper.CreateWebRequest(RaveWebServicesUrl, WebRequestMethod, ContentType, BodyData);
            SignResult signResult = MAuthHelper.SignWebRequest(webRequest, BodyData);
            if (signResult == SignResult.Success)
                WebResponse = webRequest.GetResponse();
            else
                throw new Exception("Could not sign web request");
        }

        protected virtual void SetBodyData()
        {
            throw new NotImplementedException("If element is a POST, you must set the BodyData property");
        }

        protected virtual void TakeActionAsAResultOfRWSCall() { }
	}
}
