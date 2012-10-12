using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TextTemplating;
using System.Reflection;
using System.Xml.Linq;

namespace Mediata.RBT.Documents.Templates
{
	public abstract class StepsReportBase: TextTransformation
	{
		public XElement GetModel()
		{
			string path = @"c:\";
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

			return doc;
		}

		
	}
}
