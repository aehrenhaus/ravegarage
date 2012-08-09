using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Reflection;
using System.Xml.Linq;



namespace DotNetAttributeExtractor
{


	class Program
	{
		/// <summary>
		/// usage: 
		/// xxx.exe "-output.xml" "c:\a.dll" "c:\d.dll" "d:\c.dll"
		/// </summary>
		/// <param name="args"></param>
		static void Main(string[] args)
		{
			var inputPaths = args.Where (path=>!path.StartsWith("-"));
			string outputPath = args.First(x => x.StartsWith("-"));
			outputPath = outputPath.Substring(1);

			IEnumerable<AssemAndXmlDoc> assems = inputPaths.Select(x => 
	
			{
				var assem = new AssemAndXmlDoc();
				assem.Assembly = Assembly.LoadFrom(x);
				string xmlDocPath = x.Replace(".dll", ".xml");
				if(File.Exists(xmlDocPath))
					assem.Doc = XElement.Load(xmlDocPath);
				return assem;
			});

	
			var ext = new AttributeExtractor();
			var doc = ext.ExtractMethod(assems);

			doc.Save(outputPath); 
		}
	}

	public class AssemAndXmlDoc
	{
		public XElement Doc;
		public Assembly Assembly;
	}
}
