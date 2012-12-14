using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Medidata.RBT;
using TechTalk.SpecFlow.Assist;


namespace Medidata.RBT.Features.Rave
{ 
    /// <summary>
    /// Steps to generate/run SQL to verify existence, etc of Architect objects, not visible through the UI.
    /// </summary>
    public partial class EDCSteps
    {
        /// <summary>
        /// Verify that global unit or data dictionary with the specified OID exists
        /// </summary>
        /// <param name="tableName">The name of the table to search</param>
        /// <param name="table">The values to search for</param>
        [StepDefinition(@"I verify Global ([^""]*) with OID exist")]
        public void IVerifyTableEntriesWithOIDExist(string tableName, Table table)
        {
            VerifyTableEntriesWithOIDExist(tableName, table);
        }

        /// <summary>
        /// Verify that global unit or data dictionary does not have duplicate OIDs
        /// </summary>
        /// <param name="tableName">The table to verify</param>
        [StepDefinition(@"I verify Global ([^""]*) do not have duplicate OIDs")]
        public void IVerifyTableEntriesWithOIDExistWithNoDuplicates(string tableName)
        {
            VerifyTableEntriesHaveNoDuplicates(tableName);
        }


        /// <summary>
        /// In a particular table, crf version, OIDs are unique
        /// </summary>
        /// <param name="tableName">name of table</param>
        /// <param name="OID">OID in table</param>
        /// <param name="retrieveDuplicates">should we check for duplicates in the table</param>
        /// <returns> number of occurences </returns>
        public static int GetOIDCountForGlobalEntities(string tableName, string OID = "", bool retrieveDuplicates = false)
        {
            var sql = GenerateSQLQueryForOIDSForCRFVersionAndTable(-3, tableName, OID, retrieveDuplicates);
            System.Data.DataTable dataTable;
            dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];
            return dataTable.Rows.Count;
        }


        private static void VerifyTableEntriesWithOIDExist(string tableName, Table table)
        {
            var dictionaries = table.CreateSet<ArchitectObjectModel>();
            bool found = false;
            string duplicateOIDFound = "";
            int numRecords;

            foreach (var dictionary in dictionaries)
            {
                numRecords = 0;
                numRecords = GetOIDCountForGlobalEntities(tableName.Replace(" ", ""), dictionary.OID);
                if (numRecords > 1)
                {
                    duplicateOIDFound = dictionary.OID;
                    found = false;
                    break;
                }
                else if (numRecords == 1)
                {
                    found = true;
                }
                else
                {
                    found = false;
                    break;
                }

            }

            if (duplicateOIDFound.Equals(""))
                Assert.IsTrue(found, "OIDs not found in table " + tableName + ".");
            else
                Assert.IsTrue(found, "Duplicate OID " + duplicateOIDFound + " found in table " + tableName + ".");
        }

        private static void VerifyTableEntriesHaveNoDuplicates(string tableName)
        {
            int numRecords;
            numRecords = GetOIDCountForGlobalEntities(tableName.Replace(" ", ""), "", true);
            Assert.IsTrue((numRecords == 0), "Duplicate OIDs found in table " + tableName + ".");
        }

        private static string GenerateSQLQueryForOIDSForCRFVersionAndTable(int crfVersion, string tableName, string OID = "", bool retrieveDuplicates = false)
        {
            Dictionary<string, int> allowedTables = new Dictionary<string, int>();
            allowedTables.Add("datadictionaries", 1);
            allowedTables.Add("unitdictionaries", 2);
            allowedTables.Add("variables", 3);
            if (!allowedTables.ContainsKey(tableName.ToLower()))
                throw new NotImplementedException("Method GenerateSQLQueryForOIDSForCRFVersionAndTable doesn't support table " + tableName + ".");


            string singularName;

            if (tableName.EndsWith("ies"))
                singularName = tableName.Substring(0, tableName.Length - 3) + "y";
            else
                singularName = tableName.Substring(0, tableName.Length - 1);

            string OIDCondition = "";

            if (OID.Length > 0)
                OIDCondition = " and OID = '" + OID + "'";

            if (retrieveDuplicates)
            {
                return string.Format(@"     select count({0}ID) as count, OID
                                                from {1}
                                                where crfVersionID = {2} {3}
                                                GROUP BY OID
                                                HAVING ( COUNT(OID) > 1 )
                                    ", singularName, tableName, crfVersion, OIDCondition);
            }
            else
            {
                return string.Format(@"     select {0}ID, OID
                                                from {1}
                                                where crfVersionID = {2} {3}
                                    ", singularName, tableName, crfVersion, OIDCondition);
            }
        }
	}
}
