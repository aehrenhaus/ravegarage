using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Used to perform additional functionality that coder normally does
    /// </summary>
    public sealed class CoderManagement
    {
        /// <summary>
        /// Audit a coder coding
        /// </summary>
        /// <param name="dataPointID">The ID of the datapoint to code</param>
        /// <param name="dataPointObjectTypeID">The object type being coded</param>
        /// <param name="currentUserID">The id of the current user</param>
        /// <param name="userName">The user doing the coding</param>
        /// <param name="name">The name of the datapoint</param>
        /// <param name="codingDictionaryVersion">The version of the coding dictionary</param>
        public static void AddCoderCodedAudit(
            int dataPointID, 
            int dataPointObjectTypeID, 
            int currentUserID, 
            string userName, 
            string name, 
            string codingDictionaryVersion)
        {
            StringBuilder auditValueBuilder = new StringBuilder();
            auditValueBuilder.AppendFormat(CultureInfo.InvariantCulture, "Term Coded data point by User: {0}", userName);
            auditValueBuilder.Append("|");
            auditValueBuilder.Append(name);
            auditValueBuilder.Append("|");
            auditValueBuilder.Append(codingDictionaryVersion);

            int coderUserCodedSubCategory = 228;
            string sql = string.Format(
                CoderManagement.INSERT_AUDIT, 
                dataPointID,
                dataPointObjectTypeID, 
                auditValueBuilder.ToString(), 
                currentUserID,
                DateTime.Now,
                Guid.NewGuid().ToString(),
                coderUserCodedSubCategory
                );

            DbHelper.ExecuteDataSet(sql);
        }

        #region SQL STRINGS
        #region INSERT_AUDIT
        private const string INSERT_AUDIT =
            @"
            DECLARE	@return_value int
            DECLARE @iAuditID int
            DECLARE @iErrorCode int
            
            EXEC
                @return_value = [dbo].[spAuditsInsert]
                @iObjectID = {0},
                @sObjectTypeID = {1},
                @sProperty = '',
                @sValue = '{2}',
                @sReadable = '',
                @iAuditUserID = {3},
                @daAuditTime = '{4}',
                @Guid = '{5}',
                @AuditSubCategoryID = {6},
                @iAuditID = @iAuditID OUTPUT,
                @iErrorCode = @iErrorCode OUTPUT
            
            SELECT	@iAuditID as N'@iAuditID',
             		@iErrorCode as N'@iErrorCode'
            
            SELECT	'Return Value' = @return_value
            ";
        #endregion
        #endregion
    }
}
