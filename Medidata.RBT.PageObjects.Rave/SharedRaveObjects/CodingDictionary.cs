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
		
		public List<ProjectCoderRegistration> ProjectCoderRegistrations { get; private set; }
		public List<CodingColumn> CodingColumns { get; private set; }


		public CodingDictionary(string codingDictionaryName, string dictionaryVersion)
		{
			this.ProjectCoderRegistrations = new List<ProjectCoderRegistration>();
			this.CodingColumns = new List<CodingColumn>();
			this.UniqueName = codingDictionaryName;
			this.DictionaryVersion = dictionaryVersion;
		}


		public CodingColumn GetCodingColumn(string codingColumnName) 
		{ 
			return this.CodingColumns
				.FirstOrDefault((cc) => cc.CodingColumnName.Equals(codingColumnName)); 
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
			var sql = string.Format(CodingDictionary.CREATE_CODER_SQL,
				this.UniqueName,
				this.DictionaryVersion);

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();
			this.CodingDictionaryID = (int)row["CodingDictionaryID"];
		}

		#region SQL STRINGS
		private const string CREATE_CODER_SQL =
			@"declare @CodingDictionaryID int;
			declare @CodingDictionaryInsertedTable table
			(
				CodingDictionaryID int
			);
			insert into CodingDictionaries 
			OUTPUT inserted.CodingDictionaryID into @CodingDictionaryInsertedTable
			values ('{0}', '{1}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1) 

			select @CodingDictionaryID = CodingDictionaryID from @CodingDictionaryInsertedTable

			select @CodingDictionaryID as CodingDictionaryID";
		#endregion
	}
}
