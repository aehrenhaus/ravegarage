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
    ///All objects which seed using RWS must inherit from this class
    ///</summary>
    public abstract class RWSSeededObject : UniquedSeedableObject
	{
        /// <summary>
        /// The method (POST, GET, etc) of the web request
        /// </summary>
        public string WebRequestMethod { get; set; }

        /// <summary>
        /// The type of content for the WebRequest
        /// </summary>
        public string ContentType { get; set; }

        /// <summary>
        /// The length of the content for the WebRequest
        /// </summary>
        public int? ContentLength { get; set; }

        /// <summary>
        /// The response returned from the RWS call
        /// </summary>
        protected WebResponse WebResponse { get; set; }

        /// <summary>
        /// The data in the body of the request
        /// </summary>
        protected byte[] BodyData { get; set; }

        /// <summary>
        /// The RWS URL to make the request to
        /// </summary>
        protected string RaveWebServicesUrl { get; set; }
        protected string PartialRaveWebServiceUrl { get; set; }

        protected RWSSeededObject(bool uploadAfterMakingUnique = true)
            : base(uploadAfterMakingUnique)
        {
        }

        public override void Seed()
        {
            base.Seed();
            if (UploadAfterMakingUnique)
            {
                SetBodyData();
                if (WebRequestMethod == "POST" && BodyData == null)
                    throw new Exception("Object is a POST and SetBodyData method did not set the BodyData property");
                SetRaveWebServicesURL();
                MakeRWSCall();
                TakeActionAsAResultOfRWSCall();
            }
        }

        /// <summary>
        /// Set the data that will be in the body of the WebRequest, should be overridden for POST requests
        /// </summary>
        protected virtual void SetBodyData() { throw new NotImplementedException("If element is a POST, you must set the BodyData property"); }

        /// <summary>
        /// Set the RWS URL that the call will be made to
        /// </summary>
        protected virtual void SetRaveWebServicesURL()
        {
            if (PartialRaveWebServiceUrl == null)
                throw new InvalidDataException("PartialRaveWebServiceUrl must be set in the object that inherits from RWSSeededObject.");

            RaveWebServicesUrl = string.Format("{0}{1}", RaveConfigurationGroup.Default.RWSURL, PartialRaveWebServiceUrl);
        }

        /// <summary>
        /// Make a call to RWS using the specified settings
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

        /// <summary>
        /// After the RWS call is made you may want to set some variables in the object or throw exceptions if something went wrong
        /// this is the place to put that code.
        /// </summary>
        protected virtual void TakeActionAsAResultOfRWSCall() { }
	}
}
