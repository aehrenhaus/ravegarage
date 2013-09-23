using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

namespace Medidata.RBT.PageObjects.Rave.SeedableObjects
{
    /// <summary>
    /// An eternal system. For instance, iMedidata is an external system in rave.
    /// </summary>
    public class ExternalSystem : UniquedSeedableObject
	{
		public int ExternalSystemID { get; set; }
		public int NameID { get; set; }
		public string Type { get; set; }
		public DateTime Created { get; set; }
		public DateTime Updated { get; set; }

        /// <summary>
        /// Generic constructor
        /// </summary>
        /// <param name="externalSystemName">The name of the external system</param>
        public ExternalSystem(string externalSystemName){
            UniqueName = externalSystemName;
        }

        public override void Seed()
        {
            base.Seed();
            NameID = LocalizedDataStringManagement.InsertLocalizedDataString(UniqueName);
            CreateExternalSystem(NameID);
        }

        private void CreateExternalSystem(int nameID)
        {
            string sql = string.Format(ExternalSystem.CREATE_EXTERNALSYSTEM_SQL, nameID
                , "Medidata.ExternalSystems.iMedidata, Medidata.ExternalSystems.iMedidata");

            DataRow row = DbHelper.ExecuteDataSet(sql).GetFirstRow();

            ExternalSystemID = (int)row["ExternalSystemID"];
            NameID = (int)row["NameID"];
            Type = (string)row["Type"];
            Created = (DateTime)row["Created"];
            Updated = (DateTime)row["Updated"];
        }

        private const string CREATE_EXTERNALSYSTEM_SQL =
            @"declare @nameId int;
			declare @type nvarchar(255);
            declare @date datetime;
            declare @primaryID int;

			set @date = CURRENT_TIMESTAMP;
			set @nameId = '{0}';
			set @type = '{1}';
            set @primaryID = (select MAX(ExternalSystemID) from ExternalSystems) + 1;

			Insert into ExternalSystems values (@primaryID, @nameId, @type, @date, @date);

            begin
                select * from ExternalSystems es 
					where es.NameID = @nameId
			end";
	}
}
