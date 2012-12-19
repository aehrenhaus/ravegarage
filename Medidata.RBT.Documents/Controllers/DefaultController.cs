using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Reflection;
using Mediata.RBT.Documents;

namespace Medidata.RBT.Documents.Controllers
{
    public class DefaultController : Controller
    {
        //
        // GET: /Default/

        public ActionResult Index()
        {
            return View();
        }


		public ActionResult StepDefReport()
		{
			ReadFeaturesAndStepDefs();
			return View(StepDefClasses);
		}
				
		public ActionResult StepsReport()
		{
			ReadFeaturesAndStepDefs();
			return View(Features);
		}

	
		public ActionResult FeatureComposer()
		{
			ReadFeaturesAndStepDefs();
			return View(StepDefClasses);
		}

		private void ReadFeaturesAndStepDefs()
		{
			var solutionPath = new DirectoryInfo(Server.MapPath("/") + "/..");
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

		private List<Feature> Features = new List<Feature>();

		private List<StepDefClass> StepDefClasses = new List<StepDefClass>(); 

		

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
	
    }
}
