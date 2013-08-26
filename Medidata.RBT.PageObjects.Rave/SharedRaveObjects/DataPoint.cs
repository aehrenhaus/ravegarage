using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// Object representing a rave data point
    /// </summary>
	public class DataPoint
	{
		public int DataPointID { get; set; }
        public int DataPageID { get; set; }
        public int RecordID { get; set; }
        public byte ObjectTypeID { get; set; }
        public DataPage DataPage { get; set; }
        public Record Record { get; set; }

        public DataPoint(string projectName, string subjectName, string fieldName, string data, string locale)
        {
            FetchProperties(projectName, subjectName, fieldName, data, locale);
            ObjectTypeID = GetObjectTypeID();
            DataPage = new DataPage(DataPageID);
            Record = new Record(RecordID);
        }

        private byte GetObjectTypeID()
        {
            DataRow row = DbHelper.ExecuteDataSet(DataPoint.GET_OBJECT_TYPE_ID).GetFirstRow();

            return (byte)row[0];
        }

        /// <summary>
        /// Code this datapoint just like coder does
        /// </summary>
        /// <param name="codedData">The data after coding</param>
        /// <param name="codingDictionaryVersion">The version of the coding dictionary</param>
        /// <param name="currentUserID">The ID of the current user</param>
        /// <param name="userName">The name of the user that does the coding</param>
        public void CodeDataPoint(string codedData, CodingDictionary codingDictionary, int currentUserID, string userName)
        {
            string sql = string.Format(DataPoint.CODE_DATAPOINT,
                DataPointID,
                codedData,
                codingDictionary.DictionaryVersion,
                codingDictionary.CodingColumns.First().CodingColumnID);

            DbHelper.ExecuteDataSet(sql);

            StatusManagement.RefreshStatus(DataPointID, ObjectTypeID);
            StatusManagement.RefreshStatus(DataPageID, DataPage.ObjectTypeID);
            StatusManagement.RefreshStatus(RecordID, Record.ObjectTypeID);

            CoderManagement.AddCoderCodedAudit(DataPointID, ObjectTypeID, currentUserID, userName, "DataPoint", codingDictionary.DictionaryVersion);
        }

        /// <summary>
        /// Use the project name, subject name, field name, data, and locale to get a datapoint (this only guarantees uniqueness if these combined are unique)
        /// </summary>
        /// <param name="projectName">The name of the project with the datapoint</param>
        /// <param name="subjectName">The name of the subject with the datapoint</param>
        /// <param name="fieldName">The name of the field with the datapoint</param>
        /// <param name="data">The data in the datapoint</param>
        /// <param name="locale">The locale of the datapoint</param>
        private void FetchProperties(string projectName, string subjectName, string fieldName, string data, string locale)
		{
			string sql = string.Format(DataPoint.FETCH_DATAPOINTID_USING_PROJECTNAME_SUBJECTNAME_FIELDNAME_LOCALE_AND_DATA_SQL,
                projectName,
                subjectName,
                fieldName,
                data,
                locale);

            DataRow row = DbHelper.ExecuteDataSet(sql).GetFirstRow();

            DataPointID = (int)row["DataPointID"];
            DataPageID = (int)row["DataPageID"];
            RecordID = (int)row["RecordID"];
		}

		#region SQL STRINGS
        #region FETCH_DATAPOINTID_USING_PROJECTNAME_SUBJECTNAME_FIELDNAME_LOCALE_AND_DATA_SQL
        private const string FETCH_DATAPOINTID_USING_PROJECTNAME_SUBJECTNAME_FIELDNAME_LOCALE_AND_DATA_SQL =
            @"
            declare @projectName nvarchar(256);
            declare @subjectName nvarchar(256);
            declare @fieldName nvarchar(256);
            declare @data nvarchar(256);
            declare @locale nvarchar(256);
            
            set @projectName = '{0}'
            set @subjectName = '{1}'
            set @fieldName = '{2}'
            set @data = '{3}'
            set @locale = '{4}'
            
            declare @projectID int;
            
            set @projectID = (select top 1 ProjectID from Projects p 
            inner join LocalizedDataStrings lds on p.ProjectName = lds.StringID
            where String = @projectName and Locale = @locale)
            
            declare @studyIDs table
            (
            StudyID int
            )
            insert into @studyIDs select StudyID from Studies where ProjectID = @projectID
            
            declare @fieldIDs table
            (
            FieldID int
            )
            insert into @fieldIDs select FieldID from Fields f
            inner join LocalizedDataStrings lds on f.FieldName = lds.StringID
            where String = @fieldName and Locale = @locale
            
            declare @subjectIDs table
            (
            SubjectID int
            )
            insert into @subjectIDs select SubjectID from Subjects s
            where s.SubjectName = @subjectName
            
            select * from DataPoints dp
            inner join @fieldIDs fIDs on fIDs.FieldID = dp.FieldID
            inner join @studyIDs sIDs on sIDs.StudyID = dp.StudyId
            inner join @subjectIDs subIDs on subIDs.SubjectID = dp.SubjectId
            where ReqCoderCoding = 1 and Data = @data
            ";
		#endregion

        #region CODE_DATAPOINT
        private const string CODE_DATAPOINT =
            @"
            declare @dataPointID int;
            declare @codedData nvarchar(256);
            set @dataPointID = {0}
            set @codedData = '{1}'
            update DataPoints set ReqCoderCoding = 0 where DataPointID = @dataPointID and ReqCoderCoding = 1

            DECLARE	@return_value int,
            		@CoderDecisionID int,
            		@created datetime,
            		@updated datetime,
                    @CodingColumnID int = {3},
                    @CoderValueID int,
                    @Term varchar(255) = (select data from DataPoints where DataPointID = @dataPointID)
            
            EXEC	@return_value = [dbo].[spCoderDecisionInsert]
            		@CoderDecisionID = @CoderDecisionID OUTPUT,
            		@DataPointID = {0},
            		@codingDictionaryVersion = N'{2}',
            		@created = @created OUTPUT,
            		@updated = @updated OUTPUT
            
            EXEC spCoderValueInsert @CoderValueID, @CoderDecisionID, @CodingColumnID, @codedData, @Term, @created, @updated

            SELECT	@CoderDecisionID as N'@CoderDecisionID',
            		@created as N'@created',
            		@updated as N'@updated'
            
            SELECT	'Return Value' = @return_value
            ";
        #endregion

        #region GET_OBJECT_TYPE_ID
        private const string GET_OBJECT_TYPE_ID =
            @"
            select ObjectTypeID from ObjectTypeR where ObjectName = 'Medidata.Core.Objects.DataPoint'
            ";
        #endregion

		#endregion
	}
}
