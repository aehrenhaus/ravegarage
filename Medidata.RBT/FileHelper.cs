using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;

namespace Medidata.RBT
{
    /// <summary>
    /// Class for general file functionality.
    /// </summary>
    public static class FileHelper
    {
        #region Public Methods

        /// <summary>
        /// Unzips the file
        /// </summary>
        /// <param name="fileLoc">full path to the file to be unzipped</param>
        /// <returns>full path to the unzipped file</returns>
        public static string UnZipFile(string fileLoc)
        {
            if (!File.Exists(fileLoc)) throw new Exception(String.Format("File: {0} doesn't exist", fileLoc));

            FileInfo fi = new FileInfo(fileLoc);
            string dirPath = fi.DirectoryName;
            string fileOutName;

            using (FileStream fileStreamIn = new FileStream(fileLoc, FileMode.Open, FileAccess.Read))
            {
                using (ZipInputStream zipInStream = new ZipInputStream(fileStreamIn))
                {
                    ZipEntry currentEntry = zipInStream.GetNextEntry();
                    if (currentEntry == null)
                    {
                        throw new Exception("Error Unzipping: Zip file provided is empty");
                    }

                    fileOutName = dirPath + @"\" + currentEntry.Name;

                    using (FileStream fileStreamOut = new FileStream(fileOutName, FileMode.Create, FileAccess.Write))
                    {
                        int size;
                        byte[] buffer = new byte[4096];
                        do
                        {
                            size = zipInStream.Read(buffer, 0, buffer.Length);
                            fileStreamOut.Write(buffer, 0, size);
                        } while (size > 0);
                    }
                }
            }
            return fileOutName;
        }

        #endregion Public Methods
    }
}
