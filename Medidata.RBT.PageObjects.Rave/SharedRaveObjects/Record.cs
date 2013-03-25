using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Object representing a rave record
    /// </summary>
	public class Record
	{
        public int RecordID { get; set; }
        public int ObjectTypeID { get; set; }
        public Record(int recordID)
        {
            RecordID = recordID;
            ObjectTypeID = GetObjectTypeID();
        }

        private byte GetObjectTypeID()
		{
            DataRow row = DbHelper.ExecuteDataSet(Record.GET_OBJECT_TYPE_ID).GetFirstRow();

            return (byte)row[0];
		}

		#region SQL STRINGS
        #region GET_OBJECT_TYPE_ID
        private const string GET_OBJECT_TYPE_ID =
            @"
            select ObjectTypeID from ObjectTypeR where ObjectName = 'Medidata.Core.Objects.Record'
            ";
		#endregion
		#endregion
	}
}
