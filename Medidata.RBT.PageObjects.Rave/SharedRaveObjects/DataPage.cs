using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Object representing a rave DataPage
    /// </summary>
	public class DataPage
	{
        public int DataPageID { get; set; }
        public int ObjectTypeID { get; set; }
        public DataPage(int dataPageID)
        {
            DataPageID = dataPageID;
            ObjectTypeID = GetObjectTypeID();
        }

        private byte GetObjectTypeID()
		{
            DataRow row = DbHelper.ExecuteDataSet(DataPage.GET_OBJECT_TYPE_ID).GetFirstRow();

            return (byte)row[0];
		}

		#region SQL STRINGS
        #region GET_OBJECT_TYPE_ID
        private const string GET_OBJECT_TYPE_ID =
            @"
            select ObjectTypeID from ObjectTypeR where ObjectName = 'Medidata.Core.Objects.DataPage'
            ";
		#endregion
		#endregion
	}
}
