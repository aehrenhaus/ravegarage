using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;

namespace Medidata.RBT
{

    /// <summary>
    /// 
    /// </summary>
    public class ExcelFileHelper
    {
		#region Constructors

        public ExcelFileHelper(string fileLoc, bool isZipped = false)
        {
            XmlDoc = ExcelFileHelper.OpenFile(fileLoc, isZipped);
        }

		#endregion Constructors 

		#region Properties

        //private static RBTConfiguration _config = new RBTConfiguration();

        /// <summary>
        /// Gets the XML doc representation of the excel file
        /// </summary>
        public XmlDocument XmlDoc
        {
            get;
            private set;
        }

		#endregion Properties 

		#region Public Methods


        /// <summary>
        /// Gets the spread sheet XML.
        /// </summary>
        /// <param name="nameSpace">The name space.</param>
        /// <param name="spreadSheetName">Name of the spread sheet.</param>
        /// <returns></returns>
        private XmlNode GetSpreadSheetXml(string nameSpace, string spreadSheetName)
        {
            XmlNamespaceManager nsManager = new XmlNamespaceManager(XmlDoc.NameTable);
            nsManager.AddNamespace(nameSpace, XmlDoc.DocumentElement.NamespaceURI);
            string selString = "//" + nameSpace + ":Worksheet[@" + nameSpace + ":Name='" + spreadSheetName + "']";
            XmlNode xmlNode = XmlDoc.SelectNodes(selString, nsManager).Item(0);
            return xmlNode;
        }
        #endregion Public Methods

        #region Private Methods
        private static XmlDocument OpenFile(string fileLoc, bool isZipped = false)
        {
            if (fileLoc == null) throw new Exception("Can't open a file with no name");

            if (!File.Exists(fileLoc)) throw new Exception(String.Format("File: {0} doesn't exist", fileLoc));
            //todo check file extension

            Stream stream = null;

            if (isZipped)
                fileLoc = FileHelper.UnZipFile(fileLoc);

            stream = new MemoryStream(File.ReadAllBytes(fileLoc));

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(stream);

            return xmlDoc;

        }
        #endregion Private Methods

    }

}
