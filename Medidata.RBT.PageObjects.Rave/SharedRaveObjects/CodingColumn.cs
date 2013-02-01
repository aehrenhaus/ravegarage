using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class CodingColumn :
		BaseRaveSeedableObject
	{
		public int CodingColumnID { get; private set; }
		public int CodingDictionaryID { get; private set; }
		public string CodingColumnName 
		{
			get { return this.UniqueName; }
			set { this.UniqueName = value; }
		}
		public bool DefaultCodingLevel { get; set; }
		public DateTime Created { get; private set; }
		public DateTime Updated { get; private set; }
		public string TermSuffix { get; set; }
		public string CodeSuffix { get; set; }
		public string TermSasSuffix { get; set; }
		public string CodeSasSuffix { get; set; }
		public int? TermMaxLength { get; set; }
		public int? CodeMaxLength { get; set; }

		public List<CoderDictLevelComponent> CoderDictLevelComponents { get; private set; }
		

		public CodingColumn(int codingDictionaryId)
		{
			this.CoderDictLevelComponents = new List<CoderDictLevelComponent>();
			this.CodingDictionaryID = codingDictionaryId;
		}


		public CoderDictLevelComponent GetCoderDictLevelComponent(string oid)
		{
			return this.CoderDictLevelComponents
				.FirstOrDefault((d) => d.OID.Equals(oid));
		}
		protected override void SeedFromUI()
		{
			throw new NotSupportedException("Is not currently possible to create Coding Column from Rave UI");
		}
		protected override void SeedFromBackend()
		{
			this.CreateObject();
		}
		protected override void CreateObject()
		{
			var sql = string.Format(CodingColumn.CREATE_CODING_COLUMN_SQL,
				this.CodingDictionaryID,
				this.CodingColumnName,
				DbHelper.GetSqlString(this.TermSuffix), DbHelper.GetSqlString(this.CodeSuffix),
				DbHelper.GetSqlString(this.TermSasSuffix), DbHelper.GetSqlString(this.CodeSasSuffix),
				this.TermMaxLength.HasValue 
					? this.TermMaxLength.ToString() 
					: "null",
				this.CodeMaxLength.HasValue
					? this.CodeMaxLength.ToString()
					: "null");

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();
			
			this.CodingColumnID = (int)row["CodingColumnID"];
			this.CodingDictionaryID = (int)row["CodingDictionaryID"];
			this.CodingColumnName = (string)row["CodingColumnName"];
			this.DefaultCodingLevel = (bool)row["DefaultCodingLevel"];
			this.Created = (DateTime)row["Created"];
			this.Updated = (DateTime)row["Updated"];
			this.TermSuffix = DBNull.Value.Equals(row["TermSuffix"]) ? null : (string)row["TermSuffix"];
			this.CodeSuffix = DBNull.Value.Equals(row["CodeSuffix"]) ? null : (string)row["CodeSuffix"];
			this.TermSasSuffix = DBNull.Value.Equals(row["TermSasSuffix"]) ? null : (string)row["TermSasSuffix"];
			this.CodeSasSuffix = DBNull.Value.Equals(row["CodeSasSuffix"]) ? null : (string)row["CodeSasSuffix"];
			this.TermMaxLength = row["TermMaxLength"] != DBNull.Value ? (int?)row["TermMaxLength"] : null;
			this.CodeMaxLength = row["CodeMaxLength"] != DBNull.Value ? (int?)row["CodeMaxLength"] : null;
		}

		#region CREATE_CODING_COLUMN
		private const string CREATE_CODING_COLUMN_SQL =
			@"declare @CodingColumnInsertedTable table
			(
				CodingColumnID int
			);
			
			insert into CodingColumns (CodingDictionaryID, CodingColumnName, DefaultCodingLevel, Created, Updated, TermSuffix, CodeSuffix, TermSASSuffix, CodeSASSuffix, TermMaxLength, CodeMaxLength)
			output inserted.CodingColumnID into @CodingColumnInsertedTable
			values ({0}, '{1}', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, {2}, {3}, {4}, {5}, {6}, {7})
			
			select CC.* from CodingColumns CC
			inner join @CodingColumnInsertedTable X on X.CodingColumnID = CC.CodingColumnID";
		#endregion
	}
}
