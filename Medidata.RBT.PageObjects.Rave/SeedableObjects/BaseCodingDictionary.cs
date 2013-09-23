using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
	/// <summary>
	/// Provides the base implementation of CodingDictionary. A CodingDictionary
	/// can be a classic CodingDictionary (legacy Rave subsystem) or 
	/// a CodingDictionary created by the Medidata Coder system. Both of these conceptual dictionaries
	/// are maintained in the same table; [CodingDictionaries] and are differentiated by the [isCoderDict] bit flag.
	/// This flag is 1 for the new CodingDictionary types maintained by Medidata Coder.
	/// </summary>
	public abstract class BaseCodingDictionary :
		UniquedSeedableObject
	{
		public int CodingDictionaryID { get; private set; }
		public string DictionaryName
		{
			get { return this.UniqueName; }
			set { this.UniqueName = value; }
		}
		public string DictionaryVersion { get; private set; }
		public DateTime Created { get; private set; }
		public DateTime Updated { get; private set; }
		/// <summary>
		/// Mapping of [isCoderDict] flag. Overriding types should set this to true (new CoderDictionary)
		/// or flase (legacy Rave system).
		/// </summary>
		public abstract bool IsCoderDict { get; }
		private byte IsCoderDictBit { get { return (byte)(this.IsCoderDict ? 1 : 0); } }

		public BaseCodingDictionary(string codingDictionaryName, string dictionaryVersion)
		{
			this.DictionaryName = codingDictionaryName;
			this.DictionaryVersion = dictionaryVersion;
		}

		public override void Seed()
		{
			base.Seed();
            string sql = string.Format(BaseCodingDictionary.CREATE_CODER_SQL,
                this.UniqueName,
                this.DictionaryVersion,
                this.IsCoderDictBit);

            DataRow row = DbHelper.ExecuteDataSet(sql).GetFirstRow();
            this.CodingDictionaryID = (int)row["CodingDictionaryID"];
            this.DictionaryName = (string)row["DictionaryName"];
            this.DictionaryVersion = (string)row["DictionaryVersion"];
            this.Created = (DateTime)row["Created"];
            this.Updated = (DateTime)row["Updated"];
		}

		#region SQL STRINGS
		private const string CREATE_CODER_SQL =
			@"declare @CodingDictionaryID int;
			declare @CodingDictionaryInsertedTable table
			(
				CodingDictionaryID int
			);
			insert into CodingDictionaries (DictionaryName, DictionaryVersion, Created, Updated, isCoderDict)
			OUTPUT inserted.CodingDictionaryID into @CodingDictionaryInsertedTable
			values ('{0}', '{1}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '{2}') 

			select CD.* from CodingDictionaries CD
			inner join @CodingDictionaryInsertedTable X on X.CodingDictionaryID = CD.CodingDictionaryID";
		#endregion
	}
}
