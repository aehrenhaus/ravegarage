using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Medidata.RBT.Documents.Controllers
{
    public class DocAPIController : ApiController
    {
		SpecflowProjectInfoService service;

		public DocAPIController()
		{
			string solutionPath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "../");
			service = new SpecflowProjectInfoService(solutionPath);
		}


        // GET api/docapi
		public IEnumerable<StepDefCategoryModel> Get()
        {
			var stepDefClasses = service.GetStepDefinitionClassInfo();
			var model = stepDefClasses.GroupBy(x => x.Namespace).Select(x => new StepDefCategoryModel
			{
				Name=x.Key,
				StepDefClasses = x.Select(cls=>new StepDefClassModel
				{
					Name=cls.Name,
					StepDefs=cls.Methods.SelectMany(m=>m.StepDefs).Select(y=> new StepDefModel
					{
						Name=y.RegexWithArgName,
						Comment = y.Method.Comments,
						Regex = y.Regex
					}).ToArray()
				}).ToArray()
			});

			return model;
        }

     
    }
}
