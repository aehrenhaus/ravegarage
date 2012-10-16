using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.IO;
using RazorEngine;
using System.Xml;

namespace Mediata.RBT.Documents.Templates
{
	class StepsReport:ITemplate
	{
		//if class in this dll is not used, then it will not be referenced in Razor engine, this will cause error
		private XmlDocument SystemXmlReferenceFix;

		string ITemplate.GetText()
		{
			
			string template = File.ReadAllText("Templates\\StepsReport.cshtml");

			var solutionDir = new DirectoryInfo(Assembly.GetEntryAssembly().Location).Parent.Parent.Parent.Parent;


			string path = Path.Combine( solutionDir.FullName, @"Medidata.RBT.Features.Rave\bin\Debug");



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
		//	Razor.SetTemplateBase(typeof(HtmlTemplateBase<object>));
			string result = Razor.Parse(template, doc, null);
			return result;
		}
	}

	public class AssemAndXmlDoc
	{
		public XElement Doc;
		public Assembly Assembly;
	}

	public class AttributeExtractor
	{
		public XElement ExtractMethod(IEnumerable<AssemAndXmlDoc> assemblies)
		{
			var doc = new XElement("root", assemblies.Select(x => ExtractMethodWithComment(x.Assembly, x.Doc)));
			return doc;
		}

		public IEnumerable<XElement> ExtractMethodWithComment(Assembly assembly, XElement docxml)
		{

			var typeEles = ExtractMethod(assembly).ToList();
			if (docxml == null)
				return typeEles;

			var membersDoc = docxml.Descendants("member").ToList();


			foreach (var typeEle in typeEles)
			{
				foreach (var ele in typeEle.Descendants("Method"))
				{
					var args = ele.Descendants("Arg").Select(x => x.Attribute("TypeFullName").Value).ToList();

					string methodSig = typeEle.Attribute("FullName").Value + "." + ele.Attribute("Name").Value;
					if (args.Count > 0)
					{
						methodSig += "(" + string.Join(",", args) + ")";
					}
					//M:Medidata.RBT.Common.Steps.InterfaceSteps.INavigateTo____(System.String,System.String)

					XElement docEle = membersDoc.FirstOrDefault(x => x.Attribute("name").Value == "M:" + methodSig);
					if (docEle != null)
					{
						ele.Add(new XElement("Comment", docEle.Elements()));
					}

				}
			}

			return typeEles;
		}

		public IEnumerable<XElement> ExtractMethod(Assembly assembly)
		{
			var typeEles =
					assembly
					.GetTypes()
					.Where(type => type.GetCustomAttributes(false).Any(attr => attr.GetType().Name == "BindingAttribute"))
					.Select(type =>
						new XElement("Type",
							new XAttribute("Name", type.Name),
							new XAttribute("FullName", type.FullName),
							new XElement("Methods",
									type.GetMethods().Where(m => m.GetCustomAttributes(false).Any(attr => attr.GetType().Name == "StepDefinitionAttribute" || attr.GetType().Name == "GivenAttribute" || attr.GetType().Name == "WhenAttribute" || attr.GetType().Name == "ThenAttribute"))
									.Select(m =>
										new XElement("Method",
											new XAttribute("Name", m.Name),
											new XElement("Args",
												m.GetParameters().Select(a => new XElement("Arg",
													new XAttribute("Name", a.Name),
													new XAttribute("Type", a.ParameterType.Name),
													new XAttribute("TypeFullName", a.ParameterType.FullName)
													))
												),

											new XElement("StepDefs",
												 m.GetCustomAttributes(false)
													.Where(attr => attr.GetType().Name == "StepDefinitionAttribute" || attr.GetType().Name == "GivenAttribute" || attr.GetType().Name == "WhenAttribute" || attr.GetType().Name == "ThenAttribute")
													.Select(attr =>
														new XElement("StepDef",
															new XAttribute("Regex", (attr as dynamic).Regex),
															new XAttribute("RegexWithArgName", GetRegexWithArgName((attr as dynamic).Regex, m.GetParameters()))
															)
													)
												)
										)
									)
								)
							)
						);

			return typeEles;

		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="regex"></param>
		/// <param name="parameters"></param>
		/// <returns></returns>
		private string GetRegexWithArgName(string regex, ParameterInfo[] parameters)
		{
			int index = 0;
			bool error = false;
			regex = Regex.Replace(regex, @"\([^\)]+\)", (Match m) =>
			{
				if (index < parameters.Length)
				{
					var pName = "(" + parameters[index].Name + ")";
					index++;
					return pName;
				}
				else
				{
					error = true;
					return "####ERROR####";
				}
			});

			if (parameters.Length != 0 && parameters[parameters.Length - 1].ParameterType.FullName == "TechTalk.SpecFlow.Table")
			{
				regex += "   --> (with table)";
			}

			if (error)
				regex += "   ####ERROR######################";
			return regex;
		}
	}

}
