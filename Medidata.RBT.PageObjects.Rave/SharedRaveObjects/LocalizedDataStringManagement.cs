using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Manage localized data strings (insert, remove, or otherwise maniupulate them)
    /// </summary>
    public static class LocalizedDataStringManagement
    {
        /// <summary>
        /// Insert a string into localizeddatastrings
        /// </summary>
        /// <param name="stringToLocalize">The string that needs to be added to localized data strings</param>
        /// <returns>The stringid of the inserted string</returns>
        public static int InsertLocalizedDataString(string stringToLocalize)
        {
            string sql = string.Format(LocalizedDataStringManagement.SPLOCALIZEDDATASTRINGINSERT_SQL, stringToLocalize, "eng");

            return (int)DbHelper.ExecuteDataSet(sql).GetFirstRow()["@StringID"];
        }

        private const string SPLOCALIZEDDATASTRINGINSERT_SQL =
            @"
            DECLARE	@return_value int,
		            @StringID int

            EXEC	@return_value = [dbo].[spLocalizationInsertDataString]
		            @LocalString = N'{0}',
		            @StringID = @StringID OUTPUT,
		            @Locale = N'{1}',
		            @ContextID = 1

            SELECT	@StringID as N'@StringID'
            ";
    }
}
