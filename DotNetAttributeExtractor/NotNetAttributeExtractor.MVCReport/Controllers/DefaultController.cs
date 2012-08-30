using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DotNetAttributeExtractor;
using System.Reflection;
using System.Xml.Linq;
using System.IO;

namespace NotNetAttributeExtractor.MVCReport.Controllers
{
    public class DefaultController : Controller
    {
        //
        // GET: /Default/

        public ActionResult Index(string path)
        {
			path = new DirectoryInfo(Server.MapPath("~")+"\\..\\..\\Medidata.RBT.Features.Rave\\bin\\debug\\").FullName;
			ViewBag.Path = path;
			if (!System.IO.Directory.Exists(path))
				return View();
			string[] dlls = System.IO.Directory.GetFiles(path, "*.dll");
			IEnumerable<AssemAndXmlDoc> assems = dlls.Select(x =>
			{
				var assem = new AssemAndXmlDoc();
				assem.Assembly = Assembly.LoadFrom(x);
				string xmlDocPath = x.Replace(".dll", ".xml");
				if (System.IO.File.Exists(xmlDocPath))
					assem.Doc = XElement.Load(xmlDocPath);
				return assem;
			});


			var ext = new AttributeExtractor();
			var doc = ext.ExtractMethod(assems);
			return View(doc);
        }

    }
}
