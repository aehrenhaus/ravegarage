using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.Architect.Models;
using Medidata.RBT.PageObjects.Rave.SeedableObjects;
using Medidata.RBT.PageObjects.Rave;

namespace Medidata.RBT.Features.Rave.Steps.Seeding
{
	/// <summary>
	/// Defines steps that can be used to seed Coding Dictionaries and 
	/// assign them to Projects (Studies)
	/// </summary>
	[Binding]
	public class CoderDictionarySteps
	{
		/// <summary>
		/// Creates a new ClassicCodingDictionary by executing raw sql query 
		/// to insert a record in the CodingDictionaries table.
		/// </summary>
		/// <param name="codingDictionary">DictionaryName</param>
		/// <param name="dictionaryVersion">DictionaryVersion</param>
		[StepDefinition(@"classic coding dictionary ""([^""]*)"" version ""([^""]*)"" exists")]
		public void GivenClassicCodingDictionary____Version____Exists(string codingDictionary, string dictionaryVersion)
		{
			var cd = SeedingContext.GetExistingFeatureObjectOrMakeNew(codingDictionary,
				() => new ClassicCodingDictionary(codingDictionary, dictionaryVersion));
		}

		/// <summary>
		/// Creates a new CodingDictionary by executing raw sql query to 
		/// insert a record in the CodingDictionaries table.
		/// </summary>
		/// <param name="codingDictionary">DictionaryName</param>
		/// <param name="dictionaryVersion">DictionaryVersion</param>
        /// <param name="codingColumnTable"></param>
        [StepDefinition(@"coding dictionary ""([^""]*)"" version ""([^""]*)"" exists with following coding columns")]
		public void GivenCodingDictionary____Version____ExistsWithFollowingCodingColumns____(string codingDictionary, string dictionaryVersion, Table codingColumnTable)
		{
			var cd = SeedingContext.GetExistingFeatureObjectOrMakeNew(codingDictionary,
				() => new CodingDictionary(codingDictionary, dictionaryVersion));
			
			cd.CodingColumns.AddRange(codingColumnTable
				.CreateSet<CodingColumn>(() => new CodingColumn(cd.CodingDictionaryID)));
			
			foreach (var codingColumn in cd.CodingColumns)
				codingColumn.Seed();
		}

        /// <summary>
        /// Creates a new Coding Level component by executing raw sql query to 
        /// insert a record in the CoderDictLevelComponents table
        /// </summary>
        /// <param name="codingDictionary"></param>
        /// <param name="codingColumn"></param>
        /// <param name="codingDictionaryLevelTable"></param>
        [StepDefinition(@"coding dictionary ""([^""]*)"" coding column ""([^""]*)"" has following coding level components")]
		public void GivenCodingDictionary____CodingColumn____HasFollowingCodingLevelComponents(string codingDictionary, string codingColumn, Table codingDictionaryLevelTable)
		{
			var cd = CoderDictionarySteps.FetchSeededCodingDictionary(codingDictionary);
			var cc = cd.GetCodingColumn(codingColumn);

			cc.CoderDictLevelComponents.AddRange(codingDictionaryLevelTable
				.CreateSet<CoderDictLevelComponent>(() => new CoderDictLevelComponent(cc.CodingColumnID)));

			foreach (var coderDictLevelComponent in cc.CoderDictLevelComponents)
				coderDictLevelComponent.Seed();
		}


		/// <summary>
		/// Assigns an existing CodingDictionary to an existing Project (Study) by executing raw sql queries.
		/// Throws exception if :
		///		1.	CodingDictionary is not yet seeded
		///		2.	Project (Study) is not yet seeded
		/// </summary>
		/// <param name="table">Set of Project - CodingDictionary pairs to be assigned</param>
        [StepDefinition(@"following coding dictionary assignments exist")]
		public void GivenFollowingCodingDictionaryAssignmentsExist(Table table)
		{
			var modelList = table.CreateSet<ProjectCodingDictionaryModel>();
			foreach (var model in modelList)
			{
				var cd = CoderDictionarySteps.FetchSeededCodingDictionary(model.CodingDictionary);
				var project = CoderDictionarySteps.FetchSeededProject(model.Project);

				var pcrUniqueName = ProjectCoderRegistration.CreateUniqueName(project.UniqueName, cd.UniqueName);
				cd.ProjectCoderRegistrations.Add(
					SeedingContext.GetExistingFeatureObjectOrMakeNew(pcrUniqueName,
						() => new ProjectCoderRegistration(project.UniqueName, cd.UniqueName)));
			}
		}

        /// <summary>
        /// 
        /// </summary>
        /// <param name="codingDictionaryLocaleTable"></param>
        [StepDefinition(@"following locales exist for the coding dictionary")]
        public void FollowingLocalesExistForTheCodingDictionary(Table codingDictionaryLocaleTable)
        {
            IEnumerable<CoderLocaleTable> coderLocales = codingDictionaryLocaleTable.CreateSet<CoderLocaleTable>();

            foreach (CoderLocaleTable clTable in coderLocales)
            {
                var cd = CoderDictionarySteps.FetchSeededCodingDictionary(clTable.CodingDictionaryName);
                SeedingContext.GetExistingFeatureObjectOrMakeNew(cd.UniqueName + clTable.Locale,
                    () => new CoderLocale(clTable.Locale, cd.UniqueName));
            }
        }

		private static CodingDictionary FetchSeededCodingDictionary(string codingDictionaryName)
		{
			var cd = SeedingContext.GetExistingFeatureObjectOrMakeNew<CodingDictionary>(codingDictionaryName,
				() => { throw new Exception(string.Format("Coding Dictionary [{0}] not found", codingDictionaryName)); });
			return cd;
		}
		private static Project FetchSeededProject(string projectName)
		{
			var project = SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(projectName,
				() => { throw new Exception(string.Format("Project [{0}] not found", projectName)); });
			return project;
		}
	}
}
