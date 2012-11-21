﻿using System;
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

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    ///This is a rave specific LabConfiguration. It is seedable. 
    ///These sit in Uploads/LabConfigurations.
    ///</summary>
    public class LabConfiguration : BaseRaveSeedableObject, IRemoveableObject
    {
        /// <summary>
        /// The uploaded LabConfiguration constructor. This actually uploads configurations. 
        /// These configurations should be the template plus the LabConfiguration information/LabConfiguration actions.
        /// </summary>
        /// <param name="labConfigurationUploadName">The feature defined name of the LabConfiguration</param>
		public LabConfiguration(string labConfigurationUploadName)
        {
            UniqueName = labConfigurationUploadName;
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
                MakeLabUnitsUnique(excel);
                MakeLabUnitsDictionariesUnique(excel);
                MakeLabUnitsDictionariesEntriesUnique(excel);
                MakeAnalytesUnique(excel);
                MakeLabUnique(excel);
                MakeAnalyteRangesUnique(excel);

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

                RangeType rangeType = TestContext.GetExistingFeatureObjectOrMakeNew<RangeType>(rangeTypeString.Trim(), 
                    () => new RangeType(rangeTypeString.Trim()));
                rangeTypesTable[row, "Name"] = rangeType.UniqueName.ToString();
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

                LabUnit labUnit = TestContext.GetExistingFeatureObjectOrMakeNew<LabUnit>(labUnitString.Trim(), 
                    () => new LabUnit(labUnitString.Trim()));
                labUnitsTable[row, "Name"] = labUnit.UniqueName.ToString();
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

                LabUnitDictionary labUnitDictionary = TestContext.GetExistingFeatureObjectOrMakeNew<LabUnitDictionary>(labUnitDictionaryString.Trim(),
                    () => new LabUnitDictionary(labUnitDictionaryString.Trim()));
                labUnitDictionariesTable[row, "Name"] = labUnitDictionary.UniqueName.ToString();
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

                LabUnitDictionary labUnitDictionary = TestContext.GetExistingFeatureObjectOrMakeNew<LabUnitDictionary>(labUnitDictionaryString.Trim(),
                    () => new LabUnitDictionary(labUnitDictionaryString.Trim()));
                labUnitDictionaryEntriesTable[row, "LabUnitDictionary"] = labUnitDictionary.UniqueName.ToString();
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

                Analyte analyte = TestContext.GetExistingFeatureObjectOrMakeNew<Analyte>(analyteString.Trim(), 
                    () => new Analyte(analyteString.Trim()));
                analytesTable[row, "Name"] = analyte.UniqueName.ToString();

                //Lab Unit Dictionary
                string labUnitDictionaryString = analytesTable[row, "LabUnitDictionary"] as string;

                LabUnitDictionary labUnitDictionary = TestContext.GetExistingFeatureObjectOrMakeNew<LabUnitDictionary>(labUnitDictionaryString.Trim(),
                    () => new LabUnitDictionary(labUnitDictionaryString.Trim()));
                analytesTable[row, "LabUnitDictionary"] = labUnitDictionary.UniqueName.ToString();
            }
        }

        /// <summary>
        /// Replace analyte ranges (also known as lab ranges) with the seedable object equivalents.
        /// </summary>
        /// <param name="excel">The lab configuration workbook</param>
        private void MakeAnalyteRangesUnique(ExcelWorkbook excel)
        {
            ExcelTable analyteRangesTable = excel.OpenTableForEdit("AnalyteRanges");
            for (int row = 1; row <= analyteRangesTable.RowsCount; row++)
            {
                //Lab
                string labString = analyteRangesTable[row, "Lab"] as string;

                Lab lab = TestContext.GetExistingFeatureObjectOrMakeNew<Lab>(labString.Trim(),
                    () => new Lab(labString.Trim()));
                analyteRangesTable[row, "Lab"] = lab.UniqueName.ToString();

                //Study
                string studyString = analyteRangesTable[row, "Study"] as string;

                Project project = TestContext.GetExistingFeatureObjectOrMakeNew<Project>(studyString.Trim(),
                    () => new Project(studyString.Trim(), true));
                analyteRangesTable[row, "Study"] = project.UniqueName.ToString();

                //Site
                string siteString = analyteRangesTable[row, "SiteNumber"] as string;

                Site site = TestContext.GetExistingFeatureObjectOrMakeNew<Site>(siteString.Trim(), 
                    () => new Site(siteString.Trim(), ""));
                analyteRangesTable[row, "SiteNumber"] = site.Number.ToString();

                //Analyte
                string analyteString = analyteRangesTable[row, "Analyte"] as string;

                Analyte analyte = TestContext.GetExistingFeatureObjectOrMakeNew<Analyte>(analyteString.Trim(),
                    () => new Analyte(analyteString.Trim()));
                analyteRangesTable[row, "Analyte"] = analyte.UniqueName.ToString();

                //Lab Unit
                string labUnitString = analyteRangesTable[row, "LabUnit"] as string;

                LabUnit labUnit = TestContext.GetExistingFeatureObjectOrMakeNew<LabUnit>(labUnitString.Trim(),
                    () => new LabUnit(labUnitString.Trim()));
                analyteRangesTable[row, "LabUnit"] = labUnit.UniqueName.ToString();
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

                Lab lab = TestContext.GetExistingFeatureObjectOrMakeNew<Lab>(labString.Trim(), 
                    () => new Lab(labString.Trim()));
                labsTable[row, "Name"] = lab.UniqueName.ToString();

                //Study
                string studyString = labsTable[row, "Study"] as string;

                Project project = TestContext.GetExistingFeatureObjectOrMakeNew<Project>(studyString.Trim(), 
                    () => new Project(studyString.Trim(), true));
                labsTable[row, "Study"] = project.UniqueName.ToString();

                //Site
                string siteString = labsTable[row, "SiteNumber"] as string;

                Site site = TestContext.GetExistingFeatureObjectOrMakeNew<Site>(siteString.Trim(), 
                    () => new Site(siteString.Trim(), ""));
                labsTable[row, "SiteNumber"] = site.Number.ToString();

                //RangeType
                string rangeTypeString = labsTable[row, "RangeType"] as string;

                RangeType rangeType = TestContext.GetExistingFeatureObjectOrMakeNew<RangeType>(rangeTypeString.Trim(),
                    () => new RangeType(rangeTypeString.Trim()));
                labsTable[row, "RangeType"] = rangeType.UniqueName.ToString();
            }
        }

        /// <summary>
        /// Navigate to the configuration loader page.
        /// </summary>
		protected override void NavigateToSeedPage()
        {
            TestContext.CurrentPage = new LabLoaderPage().NavigateToSelf();
        }

        /// <summary>
        /// Upload LabConfiguration. 
        /// </summary>
		protected override void CreateObject()
        {
            TestContext.CurrentPage.As<LabLoaderPage>().UploadFile(UniqueFileLocation);
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