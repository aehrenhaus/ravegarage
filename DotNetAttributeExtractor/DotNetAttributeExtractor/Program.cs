using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Reflection;



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

			IEnumerable<Assembly> assems = inputPaths.Select(path => Assembly.LoadFrom(path));
			var ext = new AttributeExtractor();
			var doc = ext.ExtractToXML(assems);

			
			outputPath = outputPath.Substring(1);
			doc.Save(outputPath); 
		}
	}
}
