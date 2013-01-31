using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.Architect.Models;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;

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
		/// Creates a new CodingDictionary by executing raw sql query to 
		/// insert a record in the CodingDictionaries table
		/// </summary>
		/// <param name="codingDictionary">DictionaryName</param>
		/// <param name="dictionaryVersion">DictionaryVersion</param>
		[Given(@"coding dictionary ""([^""]*)"" version ""([^""]*)"" exists")]
		public void GivenCodingDictionary____Version____Exists(string codingDictionary, string dictionaryVersion)
		{
			SeedingContext.GetExistingFeatureObjectOrMakeNew(codingDictionary,
				() => new CodingDictionary(codingDictionary, dictionaryVersion));
		}

		/// <summary>
		/// Assigns an existing CodingDictionary to an existing Project (Study) by executing raw sql queries.
		/// Throws exception if :
		///		1.	CodingDictionary is not yet seeded
		///		2.	Project (Study) is not yet seeded
		/// </summary>
		/// <param name="table">Set of Project - CodingDictionary pairs to be assigned</param>
		[Given(@"following coding dictionary assignments exist")]
		public void GivenFollowingCodingDictionaryAssignmentsExist(Table table)
		{
			var modelList = table.CreateSet<ProjectCodingDictionaryModel>();
			foreach (var model in modelList)
			{
				var cd = SeedingContext.GetExistingFeatureObjectOrMakeNew<CodingDictionary>(model.CodingDictionary,
					() => { throw new Exception(string.Format("Coding Dictionary [{0}] not found", model.CodingDictionary)); });
				var project = SeedingContext.GetExistingFeatureObjectOrMakeNew<Project>(model.Project,
					() => { throw new Exception(string.Format("Project [{0}] not found", model.Project)); });

				var pcrUniqueName = ProjectCoderRegistration.CreateUniqueName(project.UniqueName, cd.UniqueName);
				SeedingContext.GetExistingFeatureObjectOrMakeNew(pcrUniqueName,
					() => new ProjectCoderRegistration(project.UniqueName, cd.UniqueName));
			}
		}
	}
}
