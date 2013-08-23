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
    public static class MAuthHelper
    {
        public static System.Net.WebRequest CreateWebRequest(string url, string method, string contentType, string postData)
        {
            System.Net.WebRequest webRequest = System.Net.WebRequest.Create(url);
            webRequest.Method = method;
            if (contentType != null)
                webRequest.ContentType = contentType;

            if (method.Equals("POST", StringComparison.InvariantCultureIgnoreCase))
            {
                using (Stream dataStream = webRequest.GetRequestStream())
                {
                    byte[] postDataByteArray = Encoding.UTF8.GetBytes(postData);
                    dataStream.Write(postDataByteArray, 0, postDataByteArray.Length);
                }
            }

            return webRequest;
        }

        public static SignResult SignWebRequest(WebRequest webRequest, string body)
        {
            SignRequest signRequest = new SignRequest(webRequest, body);
            signRequest.ClientAppUuid = new System.Guid(MAuthContext.MAuthAppUUID);
            signRequest.PrivateKeyFileInfo = new System.IO.FileInfo(MAuthContext.MAuthPrivateKeyFile);
            return MAuthContext.MAuthAuthenticator.Sign(signRequest);
        }
    }
}
