﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class CoderDictLevelComponent :
		BaseRaveSeedableObject
	{
		public int ID { get; private set; }
		public int CoderDictionaryLevelId { get; private set; }
		public string OID
		{
			get { return this.UniqueName; }
			set { this.UniqueName = value; }
		}
		public DateTime Created { get; private set; }
		public DateTime Updated { get; private set; }


		public CoderDictLevelComponent(int codingColumnId)
		{
			this.CoderDictionaryLevelId = codingColumnId;
		}

		public override void Seed()
		{
			if (this.ID == 0)	//New CoderDictLevelComponent
				base.Seed();
		}
		protected override void SeedFromUI()
		{
			throw new NotSupportedException("Is not currently possible to create Coder Dict Level Component from Rave UI");
		}
		protected override void SeedFromBackend()
		{
			this.CreateObject();
		}
		protected override void CreateObject()
		{
			var sql = string.Format(CoderDictLevelComponent.CREATE_CODER_DICT_LEVEL_COMPONENT_SQL,
				this.CoderDictionaryLevelId,
				this.OID);

			var row = DbHelper.ExecuteDataSet(sql)
				.GetFirstRow();

			this.ID = (int)row["ID"];
			this.CoderDictionaryLevelId = (int)row["CoderDictionaryLevelId"];
			this.OID = (string)row["OID"];
			this.Created = (DateTime)row["Created"];
			this.Updated = (DateTime)row["Updated"];
		}

		#region CREATE_CODER_DICT_LEVEL_COMPONENT
		private const string CREATE_CODER_DICT_LEVEL_COMPONENT_SQL =
			@"declare @CoderDictLevelComponentInsertedTable table
			(
				ID int
			);

			insert into CoderDictLevelComponents (CoderDictionaryLevelId, OID, Created, Updated)
			output inserted.ID into @CoderDictLevelComponentInsertedTable
			values ({0}, '{1}', CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

			select CDLC.* from CoderDictLevelComponents CDLC
			inner join @CoderDictLevelComponentInsertedTable X on X.ID = CDLC.ID";
		#endregion
	}
}
