using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Reflection;
using System.Text.RegularExpressions;


namespace DotNetAttributeExtractor
{
	public class AttributeExtractor
	{
		public XElement ExtractToXML(IEnumerable<Assembly> assemblies)
		{
			var doc = new XElement("root",
					assemblies
					.SelectMany(assm=>assm.GetTypes())
					.Where(type => type.GetCustomAttributes(false).Any(attr => attr.GetType().Name == "BindingAttribute"))
					.Select(type=>
						new XElement("Type",
							new XAttribute("Name",type.Name),
							new XAttribute("FullName",type.FullName),
							new XElement("Methods",
									type.GetMethods().Where(m => m.GetCustomAttributes(false).Any(attr => attr.GetType().Name == "StepDefinitionAttribute" || attr.GetType().Name == "GivenAttribute" || attr.GetType().Name == "WhenAttribute" || attr.GetType().Name == "ThenAttribute"))
									.Select(m=> 
										new XElement("Method",
											new XAttribute("Name",m.Name),
											new XElement("Args",
												m.GetParameters().Select(a=>new XElement("Arg",
													new XAttribute("Name",a.Name),
													new XAttribute("Type", a.ParameterType.Name)
													))
												),
											new XElement("StepDefs",
												 m.GetCustomAttributes(false)
													.Where(attr => attr.GetType().Name == "StepDefinitionAttribute" || attr.GetType().Name == "GivenAttribute" || attr.GetType().Name == "WhenAttribute" || attr.GetType().Name == "ThenAttribute")
													.Select(attr=>
														new XElement("StepDef",
															new XAttribute("Regex", (attr as dynamic).Regex),
															new XAttribute("RegexWithArgName", GetRegexWithArgName((attr as dynamic).Regex,m.GetParameters()))
															)	
													)
												)
										)
									)
								)
							)
						)
				);

			return doc;

		}

		private string GetRegexWithArgName(string regex, ParameterInfo[] parameters)
		{
			//foreach (var p in parameters)
			//{
			//    //Table should be the last parameter
			//    if (p.ParameterType.FullName == "TechTalk.SpecFlow.Table")
			//        break;
				

			//}
			int index = 0;
			bool error = false;
			regex = Regex.Replace(regex, @"\([^\)]+\)", (Match m) =>
			{
				if (index < parameters.Length)
				{
					var pName = parameters[index].Name;
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
