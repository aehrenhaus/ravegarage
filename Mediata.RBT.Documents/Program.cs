using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using Microsoft.VisualStudio.TextTemplating;
using Mediata.RBT.Documents.Templates;
using RazorEngine;
using System.Diagnostics;

namespace Mediata.RBT.Documents
{
	public class PageModel
	{
		public string Name { get; set; }
		public string Email { get; set; }
	}
	class Program
	{
		static void Main(string[] args)
		{

			GenerateAllRazor();
			GenerateAllT4();
		}
	
		static void GenerateAllRazor()
		{
			var assem = Assembly.GetEntryAssembly();
			foreach (var type in assem.GetTypes().Where(x => x.GetInterface(typeof(ITemplate).Name)!=null))
			{
				var template = (ITemplate)Activator.CreateInstance(type);
				string str = template.GetText();

				string folder = Path.Combine(assem.Location + "/../../../", "Templates");
				string fileName = Path.Combine(folder, type.Name + ".htm");

				File.WriteAllText(fileName, str);
				Process.Start(fileName);
			}
		}

		static void GenerateAllT4()
		{
			var assem = Assembly.GetEntryAssembly();
			foreach (var type in assem.GetTypes().Where(x => !x.IsAbstract && x.IsSubclassOf(typeof(TextTransformation))))
			{
				var template = (TextTransformation)Activator.CreateInstance(type);
				var str = template.TransformText();
				string folder = Path.Combine(assem.Location + "/../../../", "Templates");
				string fileName = Path.Combine(folder, type.Name + ".htm");

				File.WriteAllText(fileName, str);
				Process.Start(fileName);
			}
		}
	}
}
