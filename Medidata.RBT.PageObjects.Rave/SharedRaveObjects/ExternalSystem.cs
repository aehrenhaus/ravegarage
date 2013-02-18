using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// An eternal system. For instance, iMedidata is an external system in rave.
    /// </summary>
    public class ExternalSystem : BaseRaveSeedableObject
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

        /// <summary>
        /// It is not possible to seed external systems from the UI.
        /// </summary>
        protected override void SeedFromUI()
        {
            throw new NotSupportedException("Is not currently possible to create External Systems from Rave UI. If you are seeing this exception, include EternalSystem in the SeedFromBackendClasses in app.config.");
        }

        /// <summary>
        /// Seed an external system directly into the DB
        /// </summary>
        protected override void SeedFromBackend()
        {
            this.MakeUnique();
            this.CreateObject();
        }

        /// <summary>
        /// Make the external system name unique
        /// </summary>
        protected override void MakeUnique()
        {
            UniqueName = UniqueName + TID;
        }

        /// <summary>
        /// Create the external system in the DB
        /// </summary>
        protected override void CreateObject()
        {
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
