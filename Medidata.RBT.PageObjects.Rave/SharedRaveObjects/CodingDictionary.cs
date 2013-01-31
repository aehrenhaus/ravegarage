using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class CodingDictionary :
		BaseRaveSeedableObject
	{
		public int CodingDictionaryID { get; private set; }
		public string DictionaryVersion { get; private set; }
		
		public ProjectCoderRegistration ProjectCoderRegistration { get; set; }


		public CodingDictionary(string codingDictionaryName, string dictionaryVersion)
		{
			this.UniqueName = codingDictionaryName;
			this.DictionaryVersion = dictionaryVersion;
		}


		protected override void MakeUnique() 
		{ 
			this.UniqueName = this.UniqueName + this.TID; 
		}
		protected override void SeedFromUI()
		{
			throw new NotSupportedException("Is not currently possible to create Coding Dictionaries from Rave UI");
		}
		protected override void SeedFromBackend()
		{
			this.MakeUnique();
			this.CreateObject();
		}
		protected override void CreateObject()
		{
			this.CreateCoder();
		}

		private void CreateCoder()
		{
			var sql = string.Format(CodingDictionary.CREATE_CODER_SQL,
				this.UniqueName,
				this.DictionaryVersion);

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();
			this.CodingDictionaryID = (int)row["CodingDictionaryID"];
		}

		#region SQL STRINGS
		private const string CREATE_CODER_SQL =
			@"declare @timeStamp as datetime;
			declare @CodingDictionaryID int
			declare @CodingDictionaryInsertedTable table
			(
				CodingDictionaryID int
			);
			insert into CodingDictionaries 
			OUTPUT inserted.CodingDictionaryID into @CodingDictionaryInsertedTable
			values ('{0}', '{1}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1) 

			select @CodingDictionaryID = CodingDictionaryID from @CodingDictionaryInsertedTable

			insert into CodingColumns
			values (@CodingDictionaryID, 'FAKE_FEATURE_CC', 1, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, null, null, null, null, null, null)

			select @CodingDictionaryID as CodingDictionaryID";
		#endregion
	}
}
