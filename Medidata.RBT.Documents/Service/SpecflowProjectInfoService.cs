using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace Medidata.RBT.Documents
{
	public class SpecflowProjectInfoService
	{
		public SpecflowProjectInfoService(string solutionPath)
		{
			this.solutionPath = solutionPath;

		}

		private string solutionPath;


		private List<Feature> Features = new List<Feature>();

		private List<StepDefClass> StepDefClasses = new List<StepDefClass>();

		private void ReadFeaturesAndStepDefs()
		{
			var solutionPath = new DirectoryInfo(this.solutionPath);
			string dllPath = Path.Combine(solutionPath.FullName, @"Medidata.RBT.Features.Rave\bin\Debug");
			string[] dllsFiles = System.IO.Directory.GetFiles(dllPath, "*.dll")
				.Where(x => x.Contains("Medidata.RBT.Features.Rave.dll") || x.Contains("Medidata.RBT.Common.Steps.dll"))
				.ToArray();

			var reader = new AssemblyDocReader();
			var asmDocs = dllsFiles.Select(x => reader.ReadAssemblyCommentInfo(x)).ToList();
			var sfReader = new StepDefsReader();
			StepDefClasses = sfReader.ReadStepDefs(asmDocs);

			ReadFeatureInFolder(Path.Combine(solutionPath.FullName, @"Medidata.RBT.Features.Rave\Features"));

			sfReader.CrossUpdateFeaturesAndStepDefs(StepDefClasses, Features);


		}

		private void ReadFeatureInFolder(string folder)
		{
			foreach (var file in Directory.GetFiles(folder, "*.feature"))
			{
				var ffReader = new GherkinParser();
				Feature feature = ffReader.Parse(file);
				Features.Add(feature);
			}

			foreach (var sub in Directory.GetDirectories(folder))
				ReadFeatureInFolder(sub);


		}

		public List<StepDefClass> GetStepDefinitionClassInfo()
		{
			ReadFeaturesAndStepDefs();
			return StepDefClasses;
		}

		public List<Feature> GetFeaturesInfo()
		{
			ReadFeaturesAndStepDefs();
			return Features;
		}
	}
}