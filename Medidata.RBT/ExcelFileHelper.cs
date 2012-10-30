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
        /// Gets the excel value.
        /// </summary>
        /// <param name="nameSpace">The name space.</param>
        /// <param name="spreadSheetName">UniqueName of the spread sheet.</param>
        /// <param name="columnName">UniqueName of the column.</param>
        /// <param name="columnPosition">The column position.</param>
        /// <param name="isZipped">if set to <c>true</c> [is zipped].</param>
        /// <returns></returns>
        public string GetExcelValue(string nameSpace, string spreadSheetName, int columnPosition, int rowPosition)
        {
            string nodeValue = "";
            XmlNode spreadSheetNode = GetSpreadSheetXml(nameSpace,spreadSheetName);
            if (spreadSheetNode == null) throw new Exception("spreadsheet being searched doesnt exist");

            XmlNamespaceManager nsManager = new XmlNamespaceManager(XmlDoc.NameTable);
            if (XmlDoc.DocumentElement != null)
                nsManager.AddNamespace(nameSpace, XmlDoc.DocumentElement.NamespaceURI);

            var xmlNodeList = spreadSheetNode.SelectNodes(nameSpace + ":Table", nsManager);
            if (xmlNodeList != null)
            {
                var xmlNode = xmlNodeList.Item(0);
                if (xmlNode != null)
                {
                    var selectNodes = xmlNode.SelectNodes(nameSpace + ":Row", nsManager);
                    if (selectNodes != null)
                    {
                        var item = selectNodes.Item(rowPosition - 1);
                        if (item != null)
                        {
                            XmlNodeList valueItems = item.SelectNodes(nameSpace + ":Cell", nsManager);

                            if (valueItems != null)
                            {
                                var node = valueItems.Item(columnPosition - 1);
                                if (node != null)
                                    return nodeValue = node.InnerText;
                            }
                        }
                    }
                }
            }
            //}
            //else
            //    throw new Exception("The column being checked doesnt exist in the spreadsheet");
            return nodeValue;

        }

        /// <summary>
        /// Spreads the sheet exists.
        /// </summary>
        /// <param name="nameSpace">The name space.</param>
        /// <param name="spreadSheetName">UniqueName of the spread sheet.</param>
        /// <returns></returns>
        public bool SpreadSheetExists(string nameSpace, string spreadSheetName)
        {
            XmlNode xmlNode = GetSpreadSheetXml(nameSpace, spreadSheetName);
            return (xmlNode != null);
        }

        /// <summary>
        /// Gets the spread sheet XML.
        /// </summary>
        /// <param name="nameSpace">The name space.</param>
        /// <param name="spreadSheetName">UniqueName of the spread sheet.</param>
        /// <returns></returns>
        private XmlNode GetSpreadSheetXml(string nameSpace, string spreadSheetName)
        {
            XmlNamespaceManager nsManager = new XmlNamespaceManager(XmlDoc.NameTable);
            nsManager.AddNamespace(nameSpace, XmlDoc.DocumentElement.NamespaceURI);
            string selString = "//" + nameSpace + ":Worksheet[@" + nameSpace + ":UniqueName='" + spreadSheetName + "']";
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
