using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Manage the status of data in the database
    /// </summary>
    public static class StatusManagement
    {
        /// <summary>
        /// Refersh object status of a certain object
        /// (This is useful to get rave to recognize coder coding)
        /// </summary>
        /// <param name="objectID">The object to refresh</param>
        /// <param name="objectTypeID">The object type to refresh</param>
        public static void RefreshStatus(int objectID, int objectTypeID)
        {
            string sql = string.Format(StatusManagement.REFRESH_STATUS, objectID, objectTypeID);

            DbHelper.ExecuteDataSet(sql);
        }

        #region SQL STRINGS
        #region REFRESH_STATUS
        private const string REFRESH_STATUS =
            @"
            spStatusAllRolesUpsert {0}, {1}
            ";
        #endregion
        #endregion
    }
}
