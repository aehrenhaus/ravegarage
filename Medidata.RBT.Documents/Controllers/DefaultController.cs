using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Reflection;
using Medidata.RBT.Documents;

namespace Medidata.RBT.Documents.Controllers
{
    public class DefaultController : Controller
    {
		SpecflowProjectInfoService service;
		public DefaultController()
		{
			string solutionPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "../");
			service = new SpecflowProjectInfoService(solutionPath);
		}

        public ActionResult Index()
        {
            return View();
        }


		public ActionResult StepDefReport()
		{
			var model = service.GetStepDefinitionClassInfo();
			return View(model);
		}
				
		public ActionResult StepsReport()
		{
			var model = service.GetFeaturesInfo();
			return View(model);
		}

	
		public ActionResult FeatureComposer()
		{
			var model = service.GetStepDefinitionClassInfo();
			return View(model);
		}

    }

	
}
