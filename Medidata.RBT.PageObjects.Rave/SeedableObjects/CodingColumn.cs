using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
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

		public CoderDictLevelComponentList CoderDictLevelComponents { get; private set; }
		

		public CodingColumn(int codingDictionaryId)
		{
			this.CoderDictLevelComponents = new CoderDictLevelComponentList();
			this.CodingDictionaryID = codingDictionaryId;
		}

		public CoderDictLevelComponent GetCoderDictLevelComponent(string oid)
		{
			return this.CoderDictLevelComponents
				.FirstOrDefault((d) => d.OID.Equals(oid));
		}

        public override void Seed()
        {
            if (this.CodingColumnID == 0)	//New Coding Column
            {
                base.Seed();
                string sql = string.Format(CodingColumn.CREATE_CODING_COLUMN_SQL,
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

                DataRow row = DbHelper.ExecuteDataSet(sql).GetFirstRow();

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

		public class CoderDictLevelComponentList : List<CoderDictLevelComponent>
		{
			private HashSet<string> _codingColumnNameSet = new HashSet<string>();

			public new void Add(CoderDictLevelComponent component)
			{
				_codingColumnNameSet.Add(component.OID);
				base.Add(component);
			}
			public new void AddRange(IEnumerable<CoderDictLevelComponent> l)
			{
				foreach (var component in l)
					if (!_codingColumnNameSet.Contains(component.OID))
						this.Add(component);
			}
		}
	}
}
