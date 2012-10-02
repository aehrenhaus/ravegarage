using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using TechTalk.SpecFlow.Assist;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Medidata.RBT.Features.Rave
{
	[Binding]
	public partial class LabAdministrationSteps : BrowserStepsBase
    {
        #region Global Data Dictionaries

        [StepDefinition(@"I add new Global Data Dictionaries")]
		public void IAddNewGlobalDataDictionaries(Table table)
		{
            CurrentPage.As<GlobalDataDictionariesPage>().IAddNewGlobalDataDictionaries(table.CreateSet<ArchitectObjectModel>());
		}

        [StepDefinition(@"I verify Global Data Dictionary names exist")]
        public void IVerifyGlobalDataDictionaryNamesExist(Table table)
        {
            bool exists = CurrentPage.As<GlobalDataDictionariesPage>().GlobalDictionariesExistWithNames(table.CreateSet<ArchitectObjectModel>());
            Assert.IsTrue(exists, "Global Data Dictionaries not found.");
        }

        [StepDefinition(@"I edit Global Data Dictionaries")]
        public void IEditGlobalDataDictionaries(Table table)
        {
            CurrentPage.As<GlobalDataDictionariesPage>().GlobalDictionariesEdit(table.CreateSet<ArchitectObjectModel>());
        }

        [StepDefinition(@"I delete Global Data Dictionaries")]
        public void IDeleteGlobalDataDictionaries(Table table)
        {
            CurrentPage.As<GlobalDataDictionariesPage>().GlobalDictionariesDelete(table.CreateSet<ArchitectObjectModel>());
        }

        #endregion

        #region Global Unit Dictionaries

        [StepDefinition(@"I add new Global Unit Dictionaries")]
        public void IAddNewGlobalUnitDictionaries(Table table)
        {
            CurrentPage.As<GlobalUnitDictionariesPage>().IAddNewGlobalUnitDictionaries(table.CreateSet<ArchitectObjectModel>());
        }

        [StepDefinition(@"I verify Global Unit Dictionary names exist")]
        public void IVerifyGlobalUnitDictionaryNamesExist(Table table)
        {
            bool exists = CurrentPage.As<GlobalUnitDictionariesPage>().GlobalDictionariesExistWithNames(table.CreateSet<ArchitectObjectModel>());
            Assert.IsTrue(exists, "Global Data Dictionaries not found.");
        }

        [StepDefinition(@"I edit Global Unit Dictionaries")]
        public void IEditGlobalUnitDictionaries(Table table)
        {
            CurrentPage.As<GlobalUnitDictionariesPage>().GlobalDictionariesEdit(table.CreateSet<ArchitectObjectModel>());
        }

        [StepDefinition(@"I delete Global Unit Dictionaries")]
        public void IDeleteGlobalUnitDictionaries(Table table)
        {
            CurrentPage.As<GlobalUnitDictionariesPage>().GlobalDictionariesDelete(table.CreateSet<ArchitectObjectModel>());
        }

        #endregion

        #region Lab Unit Dictionaries

        [StepDefinition(@"I add new Lab Unit Dictionaries")]
        public void IAddNewLabUnitDictionaries(Table table)
        {
            CurrentPage.As<LabUnitDictionariesPage>().IAddNewLabUnitDictionaries(table.CreateSet<ArchitectObjectModel>());
        }

        [StepDefinition(@"I verify Lab Unit Dictionary names exist")]
        public void IVerifyLabUnitDictionaryNamesExist(Table table)
        {
            bool exists = CurrentPage.As<LabUnitDictionariesPage>().LabUnitDictionariesExistWithNames(table.CreateSet<ArchitectObjectModel>());
            Assert.IsTrue(exists, "Lab Unit Dictionaries not found.");
        }

        [StepDefinition(@"I edit Lab Unit Dictionaries")]
        public void IEditLabUnitDictionaries(Table table)
        {
            CurrentPage.As<LabUnitDictionariesPage>().LabUnitDictionariesEdit(table.CreateSet<ArchitectObjectModel>());
        }

        [StepDefinition(@"I delete Lab Unit Dictionaries")]
        public void IDeleteLabUnitDictionaries(Table table)
        {
            CurrentPage.As<LabUnitDictionariesPage>().LabUnitDictionariesDelete(table.CreateSet<ArchitectObjectModel>());
        }

        #endregion

        //#region Global Variables

        //[StepDefinition(@"I add new Global Variables")]
        //public void IAddNewGlobalVariables(Table table)
        //{
        //    CurrentPage.As<GlobalVariablesPage>().IAddNewGlobalVariables(table.CreateSet<ArchitectObjectModel>());
        //}

        //[StepDefinition(@"I verify Global Variable names exist")]
        //public void IVerifyGlobalVariableNamesExist(Table table)
        //{
        //    bool exists = CurrentPage.As<GlobalVariablesPage>().GlobalDictionariesExistWithNames(table.CreateSet<ArchitectObjectModel>());
        //    Assert.IsTrue(exists, "Global Data Dictionaries not found.");
        //}

        //[StepDefinition(@"I edit Global Variables")]
        //public void IEditGlobalVariables(Table table)
        //{
        //    CurrentPage.As<GlobalVariablesPage>().GlobalDictionariesEdit(table.CreateSet<ArchitectObjectModel>());
        //}

        //[StepDefinition(@"I delete Global Variables")]
        //public void IDeleteGlobalVariables(Table table)
        //{
        //    CurrentPage.As<GlobalVariablesPage>().GlobalDictionariesDelete(table.CreateSet<ArchitectObjectModel>());
        //}

        //#endregion
    }
}
