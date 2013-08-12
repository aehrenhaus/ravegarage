using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using TechTalk.SpecFlow;
using Medidata.RBT.SeleniumExtension;
using OpenQA.Selenium;
using System.Collections.ObjectModel;
using System.IO;
using System.Xml;
using Medidata.RBT.PageObjects.Rave.UserAdministrator;
using Medidata.RBT.PageObjects.Rave.Configuration;
using Medidata.RBT.SharedObjects;
using Medidata.RBT.SharedRaveObjects;
using Medidata.RBT.PageObjects.Rave.Lab;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific LabConfiguration. It is seedable. 
    ///These sit in Uploads/LabConfigurations.
    ///</summary>
    public class LabConfiguration : BaseRaveSeedableObject, IRemoveableObject
    {

        /// <summary>
        /// When using "literal" names, no seeding of names is done.  We need this to test string length limits, etc.
        /// </summary>
        public bool MaintainStringLength { get; set; } //maintain the length of the uploaded strings

        /// <summary>
        /// The uploaded LabConfiguration constructor. This actually uploads configurations. 
        /// These configurations should be the template plus the LabConfiguration information/LabConfiguration actions.
        /// </summary>
        /// <param name="labConfigurationUploadName">The feature defined name of the LabConfiguration</param>
        /// <param name="useLiteralNames">use actual unadulterated names</param>
        public LabConfiguration(string labConfigurationUploadName, bool maintainStringLength = false, bool redirectAfterSeed = true)
        {
            UniqueName = labConfigurationUploadName;
            MaintainStringLength = maintainStringLength;
            RedirectAfterSeed = redirectAfterSeed;
        }

        /// <summary>
        /// Load the xml to upload. Replace the LabConfiguration name with a unique version of it with a TID at the end.
        /// </summary>
		protected override void MakeUnique()
        {
            FileLocation = RBTConfiguration.Default.UploadPath + @"\LabConfigurations\" + UniqueName;

            UniqueName = UniqueName + TID;

            using (ExcelWorkbook excel = new ExcelWorkbook(FileLocation))
            {
                MakeRangeTypesUnique(excel);
                MakeRangeTypeVariablesUnique(excel);
                MakeLabUnitsUnique(excel);
                MakeLabUnitsDictionariesUnique(excel);
                MakeLabUnitsDictionariesEntriesUnique(excel);
                MakeAnalytesUnique(excel);
                MakeLabUnique(excel);
                MakeGlobalVariablesUnique(excel);
                MakeAnalyteRangesUnique(excel);
                MakeUnitConversionAnalyteUnique(excel);
                MakeStandardGroupUnique(excel);
                MakeStandardGroupEntriesUnique(excel);
                

                //Create a unique version of the file to upload
                UniqueFileLocation = MakeFileLocationUnique(FileLocation);

                //Create a unique version of the file to upload
                excel.SaveAs(UniqueFileLocation);
            }
        }

        /// <summary>
        /// Replace range types with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeRangeTypesUnique(ExcelWorkbook excel)
        {
            ExcelTable rangeTypesTable = excel.OpenTableForEdit("RangeTypes");
            for (int row = 1; row <= rangeTypesTable.RowsCount; row++)
            {
                //Name
                string rangeTypeString = rangeTypesTable[row, "Name"] as string;
                if (!string.IsNullOrEmpty(rangeTypeString))
                {
                    RangeType rangeType = SeedingContext.GetExistingFeatureObjectOrMakeNew<RangeType>(rangeTypeString.Trim(),
                        () => new RangeType(rangeTypeString.Trim()));
                    rangeTypesTable[row, "Name"] = rangeType.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Replace global variables with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeGlobalVariablesUnique(ExcelWorkbook excel)
        {
            ExcelTable globalVariableTable = excel.OpenTableForEdit("GlobalVariables");
            for (int row = 1; row <= globalVariableTable.RowsCount; row++)
            {
                //Name
                string globalVariableString = globalVariableTable[row, "OID"] as string;
                if (!string.IsNullOrEmpty(globalVariableString))
                {
                    GlobalVariable globalVariable = SeedingContext.GetExistingFeatureObjectOrMakeNew<GlobalVariable>(globalVariableString.Trim(),
                        () => new GlobalVariable(globalVariableString.Trim()));
                    globalVariable.UniqueName = RemoveCharactersFromStringEqualToTIDLength(globalVariable);
                    globalVariableTable[row, "OID"] = globalVariable.UniqueName;
                }
            }
        }

        private string RemoveCharactersFromStringEqualToTIDLength(BaseRaveSeedableObject originalSeedableObject)
        {
            string ret = originalSeedableObject.UniqueName;

            if (!MaintainStringLength)
                return ret;

            int tidLength = originalSeedableObject.TID.Length;
            int startOfTid = ret.IndexOf(originalSeedableObject.TID);
            if (MaintainStringLength && startOfTid - tidLength > 0)
                ret = ret.Substring(0, startOfTid - tidLength) + originalSeedableObject.TID;
            return ret;
        }

		/// <summary>
		/// Replace range type variables with the seedable object equivalents.
		/// </summary>
		/// <param name="excel">The lab configuration workbook</param>
		private void MakeRangeTypeVariablesUnique(ExcelWorkbook excel)
		{
			ExcelTable rangeTypeVariablesTable = excel.OpenTableForEdit("RangeTypeVariables");
			for (int row = 1; row <= rangeTypeVariablesTable.RowsCount; row++)
			{
				//Name
				string rangeTypeString = rangeTypeVariablesTable[row, "RangeType"] as string;
				if (!string.IsNullOrEmpty(rangeTypeString))
				{
					RangeType rangeType = SeedingContext.GetExistingFeatureObjectOrMakeNew<RangeType>(rangeTypeString.Trim(),
						() => new RangeType(rangeTypeString.Trim()));
					rangeTypeVariablesTable[row, "RangeType"] = rangeType.UniqueName.ToString();
				}

                //GloablVariables
                string globalVariableString = rangeTypeVariablesTable[row, "GlobalVariable"] as string;
                if (!string.IsNullOrEmpty(globalVariableString))
                {
                    GlobalVariable globalVariable = SeedingContext.GetExistingFeatureObjectOrMakeNew<GlobalVariable>(globalVariableString.Trim(),
                        () => new GlobalVariable(globalVariableString.Trim()));
                    rangeTypeVariablesTable[row, "GlobalVariable"] = globalVariable.UniqueName.ToString();
                }
			}
		}

		/// <summary>
        /// Replace lab units with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeLabUnitsUnique(ExcelWorkbook excel)
        {
            ExcelTable labUnitsTable = excel.OpenTableForEdit("LabUnits");
            for (int row = 1; row <= labUnitsTable.RowsCount; row++)
            {
                //Name
                string labUnitString = labUnitsTable[row, "Name"] as string;
                if (!string.IsNullOrEmpty(labUnitString))
                {
                    LabUnit labUnit = SeedingContext.GetExistingFeatureObjectOrMakeNew<LabUnit>(labUnitString.Trim(),
                        () => new LabUnit(labUnitString.Trim()));
                    labUnitsTable[row, "Name"] = labUnit.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Replace lab unit dictionaries with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeLabUnitsDictionariesUnique(ExcelWorkbook excel)
        {
            ExcelTable labUnitDictionariesTable = excel.OpenTableForEdit("LabUnitDictionaries");
            for (int row = 1; row <= labUnitDictionariesTable.RowsCount; row++)
            {
                //Name
                string labUnitDictionaryString = labUnitDictionariesTable[row, "Name"] as string;
                if (!string.IsNullOrEmpty(labUnitDictionaryString))
                {
                    LabUnitDictionary labUnitDictionary = SeedingContext.GetExistingFeatureObjectOrMakeNew<LabUnitDictionary>(labUnitDictionaryString.Trim(),
                        () => new LabUnitDictionary(labUnitDictionaryString.Trim()));
                    labUnitDictionariesTable[row, "Name"] = labUnitDictionary.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Replace lab unit dictionary entries with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeLabUnitsDictionariesEntriesUnique(ExcelWorkbook excel)
        {
            ExcelTable labUnitDictionaryEntriesTable = excel.OpenTableForEdit("LabUnitDictionaryEntries");
            for (int row = 1; row <= labUnitDictionaryEntriesTable.RowsCount; row++)
            {
                //Name
                string labUnitDictionaryString = labUnitDictionaryEntriesTable[row, "LabUnitDictionary"] as string;

                if (!string.IsNullOrEmpty(labUnitDictionaryString))
                {
                    LabUnitDictionary labUnitDictionary = SeedingContext.GetExistingFeatureObjectOrMakeNew<LabUnitDictionary>(labUnitDictionaryString.Trim(),
                        () => new LabUnitDictionary(labUnitDictionaryString.Trim()));
                    labUnitDictionary.UniqueName = RemoveCharactersFromStringEqualToTIDLength(labUnitDictionary);
                    labUnitDictionaryEntriesTable[row, "LabUnitDictionary"] = labUnitDictionary.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Replace analytes with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeAnalytesUnique(ExcelWorkbook excel)
        {
            ExcelTable analytesTable = excel.OpenTableForEdit("Analytes");
            for (int row = 1; row <= analytesTable.RowsCount; row++)
            {
                //Name
                string analyteString = analytesTable[row, "Name"] as string;

                if (!string.IsNullOrEmpty(analyteString))
                {
                    Analyte analyte = SeedingContext.GetExistingFeatureObjectOrMakeNew<Analyte>(analyteString.Trim(), 
                        () => new Analyte(analyteString.Trim()));
                    analytesTable[row, "Name"] = analyte.UniqueName.ToString();
                }
                //Lab Unit Dictionary
                string labUnitDictionaryString = analytesTable[row, "LabUnitDictionary"] as string;
                if (!string.IsNullOrEmpty(labUnitDictionaryString))
                {
                    LabUnitDictionary labUnitDictionary = SeedingContext.GetExistingFeatureObjectOrMakeNew<LabUnitDictionary>(labUnitDictionaryString.Trim(),
                        () => new LabUnitDictionary(labUnitDictionaryString.Trim()));
                    analytesTable[row, "LabUnitDictionary"] = labUnitDictionary.UniqueName.ToString();
                }
                
            }
        }

        /// <summary>
        /// Replace the range type name in the analyte ranges column title with the unique version
        /// </summary>
        /// <param name="columnTitle">The existing column title, is returned as the version that is made unique</param>
        /// <param name="rangeTypeDictionary">Dictionary containing all RangeTypes which have already been seeded</param>
        /// <returns>The length of the rangeType variable so that we may do the correct substring operations later</returns>
        private int? ReplaceRangeTypeNamesWithUniqueVersion(ref string columnTitle, Dictionary<string, string> rangeTypeDictionary)
        {
            int? lengthOfRangeType = null;
            foreach (KeyValuePair<string, string> rangeType in rangeTypeDictionary)
            {
                if (columnTitle.StartsWith(rangeType.Key))
                {
                    columnTitle = rangeType.Value + columnTitle.Substring(rangeType.Key.Length, columnTitle.Length - rangeType.Key.Length);
                    lengthOfRangeType = rangeType.Value.Length;
                    break;
                }
            }

            return lengthOfRangeType;
        }

        /// <summary>
        /// Replace the global variable name in the analyte ranges column title with the unique version.
        /// The column will be in the format "RangeType_GlobalVariable_HighValueLabelOrLowValueLabel"
        /// </summary>
        /// <param name="columnTitle">The existing column title, is returned as the version that is made unique</param>
        /// <param name="globalVariableDictionary">Dictionary containing all GlobalVariables which have already been seeded</param>
        /// <param name="lengthOfRangeType">The length of the rangeType variable so that we may do the correct substring operations</param>
        private void ReplaceGlobalVariableNamesWithUniqueVersion(
            ref string columnTitle, 
            Dictionary<string, string> globalVariableDictionary,
            int lengthOfRangeType)
        {
            foreach (KeyValuePair<string, string> globalVariable in globalVariableDictionary)
            {
                string columnTitleWithoutRangeType = columnTitle.Substring(lengthOfRangeType + "_".Length, columnTitle.Length - (lengthOfRangeType + "_".Length));
                if (columnTitleWithoutRangeType.StartsWith(globalVariable.Key))
                {
                    StringBuilder columnTitleSB = new StringBuilder();
                    columnTitleSB.Append(columnTitle.Substring(0, lengthOfRangeType)); //RangeType
                    columnTitleSB.Append('_');
                    columnTitleSB.Append(globalVariable.Value);
                    columnTitleSB.Append('_');
                    int indexOfStringToReplace = lengthOfRangeType + "_".Length + globalVariable.Key.Length + "_".Length;
                    columnTitleSB.Append(columnTitle.Substring(indexOfStringToReplace, columnTitle.Length - indexOfStringToReplace));//Rest of the column title
                    columnTitle = columnTitleSB.ToString();
                    break;
                }
            }
        }

        /// <summary>
        /// The column headers for analyte ranges can contain both RangeTypes and GlobalVariables, 
        /// so we need to replace these with the unique versions of themselves which we made unique earlier
        /// </summary>
        /// <param name="analyteRangesTable">The table containing the analyte ranges</param>
        /// <param name="rangeTypeDictionary">Dictionary containing all RangeTypes which have already been seeded</param>
        /// <param name="globalVariableDictionary">Dictionary containing all GlobalVariables which have already been seeded</param>
        private void RenameColumnHeadersForAnalyteRanges(
            ExcelTable analyteRangesTable, 
            Dictionary<string, string> rangeTypeDictionary, 
            Dictionary<string, string> globalVariableDictionary)
        {
            for (int i = 0; i < analyteRangesTable.ColumnNames.Length; i++)
			{
                string columnTitle = analyteRangesTable.ColumnNames[i];
                int? lengthOfRangeType = ReplaceRangeTypeNamesWithUniqueVersion(ref columnTitle, rangeTypeDictionary);
                if(lengthOfRangeType.HasValue)
                    ReplaceGlobalVariableNamesWithUniqueVersion(ref columnTitle, globalVariableDictionary, lengthOfRangeType.Value);

                analyteRangesTable[0, analyteRangesTable.ColumnNames[i]] = columnTitle;
			}
        }

        /// <summary>
        /// Replace analyte ranges (also known as lab ranges) with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeAnalyteRangesUnique(ExcelWorkbook excel)
        {
			//identify the rangeTypes with uniquename
			ExcelTable rangeTypesTable = excel.OpenTableForEdit("RangeTypes");
			for (int row = 1; row <= rangeTypesTable.RowsCount; row++)
			{
				string rangeTypeString = rangeTypesTable[row, "Name"] as string;
				RangeType rangeType = SeedingContext.GetExistingFeatureObjectOrMakeNew<RangeType>(rangeTypeString.Trim(),
					() => new RangeType(rangeTypeString.Trim()));
			}

            Dictionary<string, string> rangeTypeDictionary
                = SeedingContext.SeedableObjects.Where(x => x.Value.GetType() == typeof(RangeType))
                .ToDictionary(so => so.Key, so => so.Value.UniqueName);

            Dictionary<string, string> globalVariableDictionary
                = SeedingContext.SeedableObjects.Where(x => x.Value.GetType() == typeof(GlobalVariable))
                .ToDictionary(so => so.Key, so => so.Value.UniqueName);

            ExcelTable analyteRangesTable = excel.OpenTableForEdit("AnalyteRanges");
            RenameColumnHeadersForAnalyteRanges(analyteRangesTable, rangeTypeDictionary, globalVariableDictionary);


            for (int row = 1; row <= analyteRangesTable.RowsCount; row++)
            {
                //Lab
                string labString = analyteRangesTable[row, "Lab"] as string;
                if (!string.IsNullOrEmpty(labString))
                {
                    Lab lab = SeedingContext.GetExistingFeatureObjectOrMakeNew<Lab>(labString.Trim(),
                        () => new Lab(labString.Trim()));
                    analyteRangesTable[row, "Lab"] = lab.UniqueName.ToString();
                }

                //Study
                string studyString = analyteRangesTable[row, "Study"] as string;
                if (!string.IsNullOrEmpty(studyString))
                {
                    Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(studyString.Trim(),
                        () => new Project(studyString.Trim(), true));
                    analyteRangesTable[row, "Study"] = project.UniqueName.ToString();
                }
                //Site
                string siteString = analyteRangesTable[row, "SiteNumber"] as string;
                if (!string.IsNullOrEmpty(siteString))
                {
                    Site site = SeedingContext.GetExistingFeatureObjectOrMakeNew<Site>(siteString.Trim(),
                        () => new Site(siteString.Trim(), ""));
                    analyteRangesTable[row, "SiteNumber"] = site.Number.ToString();
                }
                //Analyte
                string analyteString = analyteRangesTable[row, "Analyte"] as string;
                if (!string.IsNullOrEmpty(analyteString))
                {
                    Analyte analyte = SeedingContext.GetExistingFeatureObjectOrMakeNew<Analyte>(analyteString.Trim(),
                        () => new Analyte(analyteString.Trim()));
                    analyteRangesTable[row, "Analyte"] = analyte.UniqueName.ToString();
                }
                //Lab Unit
                string labUnitString = analyteRangesTable[row, "LabUnit"] as string;
                if (!string.IsNullOrEmpty(labUnitString))
                {
                    LabUnit labUnit = SeedingContext.GetExistingFeatureObjectOrMakeNew<LabUnit>(labUnitString.Trim(),
                        () => new LabUnit(labUnitString.Trim()));
                    analyteRangesTable[row, "LabUnit"] = labUnit.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Make the lab unique. This does not give it a unique name so you can select it in EDC.
        /// It does replace the other items that the lab references with their seedable objects.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeLabUnique(ExcelWorkbook excel)
        {
            ExcelTable labsTable = excel.OpenTableForEdit("Labs");
            for (int row = 1; row <= labsTable.RowsCount; row++)
            {
                //Name
                string labString = labsTable[row, "Name"] as string;

                if (!string.IsNullOrEmpty(labString))
                {
                    Lab lab = SeedingContext.GetExistingFeatureObjectOrMakeNew<Lab>(labString.Trim(), 
                        () => new Lab(labString.Trim()));
                    labsTable[row, "Name"] = lab.UniqueName.ToString();
                }
                //Study
                string studyString = labsTable[row, "Study"] as string;
                if (!string.IsNullOrEmpty(studyString))
                {
                    Project project = SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(studyString.Trim(),
                        () => new Project(studyString.Trim(), true));
                    labsTable[row, "Study"] = project.UniqueName.ToString();
                }
                //Site
                string siteString = labsTable[row, "SiteNumber"] as string;
                if (!string.IsNullOrEmpty(siteString))
                {
                    Site site = SeedingContext.GetExistingFeatureObjectOrMakeNew<Site>(siteString.Trim(),
                        () => new Site(siteString.Trim(), ""));
                    labsTable[row, "SiteNumber"] = site.Number.ToString();
                }
                //RangeType
                string rangeTypeString = labsTable[row, "RangeType"] as string;
                if (!string.IsNullOrEmpty(rangeTypeString))
                {
                    RangeType rangeType = SeedingContext.GetExistingFeatureObjectOrMakeNew<RangeType>(rangeTypeString.Trim(),
                        () => new RangeType(rangeTypeString.Trim()));
                    labsTable[row, "RangeType"] = rangeType.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Make top/bottom analyte name unique in unit  conversions table
        /// </summary>
        /// <param name="excel"></param>
        private void MakeUnitConversionAnalyteUnique(ExcelWorkbook excel)
        {
            ExcelTable unitConversionsTable = excel.OpenTableForEdit("UnitConversions");
            for (int row = 1; row <= unitConversionsTable.RowsCount; row++)
            {
                //TopAnalyteFormula
                string topAnalyteString = unitConversionsTable[row, "TopAnalyteInFormula"] as string;

                if (!string.IsNullOrEmpty(topAnalyteString))
                {
                    Analyte topAnalyte = SeedingContext.GetExistingFeatureObjectOrMakeNew<Analyte>(topAnalyteString.Trim(),
                        () => new Analyte(topAnalyteString.Trim()));
                    unitConversionsTable[row, "TopAnalyteInFormula"] = topAnalyte.UniqueName.ToString();
                }
                //BottonAnalyteFormula
                string bottomAnalyteString = unitConversionsTable[row, "BottomAnalyteInFormula"] as string;
                if (!string.IsNullOrEmpty(bottomAnalyteString))
                {
                    Analyte bottomAnalyte = SeedingContext.GetExistingFeatureObjectOrMakeNew<Analyte>(bottomAnalyteString.Trim(),
                        () => new Analyte(bottomAnalyteString.Trim()));
                    unitConversionsTable[row, "BottomAnalyteInFormula"] = bottomAnalyte.UniqueName.ToString();
                }

            }
        }

        /// <summary>
        /// Make the standard group unique
        /// </summary>
        /// <param name="excel"></param>
        private void MakeStandardGroupUnique(ExcelWorkbook excel)
        {
            ExcelTable standardGroupsTable = excel.OpenTableForEdit("StandardGroups");
            for (int row = 1; row <= standardGroupsTable.RowsCount; row++)
            {
                //Name
                string standardGroupString = standardGroupsTable[row, "Name"] as string;

                if (!string.IsNullOrEmpty(standardGroupString))
                {
                    StandardGroup lab = SeedingContext.GetExistingFeatureObjectOrMakeNew<StandardGroup>(standardGroupString.Trim(),
                        () => new StandardGroup(standardGroupString.Trim()));
                    standardGroupsTable[row, "Name"] = lab.UniqueName.ToString();
                }
            }
        }

        /// <summary>
        /// Make the standard group entries unique
        /// </summary>
        /// <param name="excel"></param>
        private void MakeStandardGroupEntriesUnique(ExcelWorkbook excel)
        {
            ExcelTable standardGroupEntriesTable = excel.OpenTableForEdit("StandardGroupEntries");

            for (int row = 1; row <= standardGroupEntriesTable.RowsCount; row++)
            {
                //Standard group
                string standardGroupString = standardGroupEntriesTable[row, "StandardGroup"] as string;

                if (!string.IsNullOrEmpty(standardGroupString))
                {
                    StandardGroup standardGroup = SeedingContext.GetExistingFeatureObjectOrMakeNew<StandardGroup>(standardGroupString.Trim(),
                        () => new StandardGroup(standardGroupString.Trim()));
					standardGroupEntriesTable[row, "StandardGroup"] = standardGroup.UniqueName.ToString();
                }

                //Analyte
                string analyteString = standardGroupEntriesTable[row, "Analyte"] as string;
                if (!string.IsNullOrEmpty(analyteString))
                {
                    Analyte analyte = SeedingContext.GetExistingFeatureObjectOrMakeNew<Analyte>(analyteString.Trim(),
                        () => new Analyte(analyteString.Trim()));
                    standardGroupEntriesTable[row, "Analyte"] = analyte.UniqueName.ToString();
                }

            }
        }

        /// <summary>
        /// Navigate to the configuration loader page.
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            WebTestContext.CurrentPage = new LabLoaderPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload LabConfiguration. 
        /// </summary>
		protected override void CreateObject()
        {
            WebTestContext.CurrentPage.As<LabLoaderPage>().UploadFile(UniqueFileLocation);
        }

        /// <summary>
        /// Delete the unique LabConfiguration created by seeding
        /// </summary>
        public void DeleteSelf()
        {
            File.Delete(UniqueFileLocation);
        }
    }
}
