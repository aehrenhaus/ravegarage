using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;
using System.Net;
using Medidata.MAuth;
using System.IO;

namespace Medidata.RBT.Helpers
{
    /// <summary>
    /// Helper class to assist with MAuth calls
    /// </summary>
    public static class MAuthHelper
    {
        /// <summary>
        /// Create a WebRequest to send to Mauth
        /// </summary>
        /// <param name="url">The url for the WebRequest</param>
        /// <param name="method">The method for the WebRequest(POST, GET, etc)</param>
        /// <param name="contentType">The type of content to send</param>
        /// <param name="postData">The data to post, if there is some</param>
        /// <returns>The fully formatted WebRequest</returns>
        public static System.Net.WebRequest CreateWebRequest(string url, string method, string contentType, byte[] postData = null)
        {
            System.Net.WebRequest webRequest = System.Net.WebRequest.Create(url);

            webRequest.Method = method;
            if (contentType != null)
                webRequest.ContentType = contentType;

            if (method.Equals("POST", StringComparison.InvariantCultureIgnoreCase))
            {
                using (Stream dataStream = webRequest.GetRequestStream())
                {
					dataStream.Write(postData, 0, postData.Length);
                }
            }

            return webRequest;
        }

        /// <summary>
        /// Sign the WebRequest using MAuth
        /// </summary>
        /// <param name="webRequest">The WebRequest to sign</param>
        /// <param name="body">The body of the webrequest</param>
        /// <returns>The result of signing the webrequest, it is SignResult.Success if it is successful</returns>
        public static SignResult SignWebRequest(WebRequest webRequest, byte[] body)
        {
            SignRequest signRequest = new SignRequest(webRequest, System.Text.Encoding.UTF8.GetString(body));
            signRequest.ClientAppUuid = new System.Guid(MAuthContext.MAuthAppUUID);
            signRequest.PrivateKeyFileInfo = new System.IO.FileInfo(MAuthContext.MAuthPrivateKeyFile);
            return MAuthContext.MAuthAuthenticator.Sign(signRequest);
        }
    }
}
