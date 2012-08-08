using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DotNetAttributeExtractor;
using System.Reflection;
using System.Xml.Linq;

namespace NotNetAttributeExtractor.MVCReport.Controllers
{
    public class DefaultController : Controller
    {
        //
        // GET: /Default/

        public ActionResult Index(string path)
        {
		
			ViewBag.Path = path;
			if (!System.IO.Directory.Exists(path))
				return View();
			string[] dlls = System.IO.Directory.GetFiles(path,"*.dll");
			IEnumerable<Assembly> assems = dlls.Where (p=>!p.StartsWith("-")).Select(p => Assembly.LoadFrom(p));
			
			var ext = new AttributeExtractor();
			XElement xml = ext.ExtractToXML(assems);

			return View(xml);
        }

    }
}
