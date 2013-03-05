using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using System.Collections;

namespace Medidata.RBT.Documents
{


	public class StepDefsReader
	{
		internal void CrossUpdateFeaturesAndStepDefs(List<StepDefClass> stepDefClasses, List<Feature> features)
		{
			var allRegexes = stepDefClasses.SelectMany(x=>x.Methods).SelectMany(x=>x.StepDefs)
				.OrderBy(x=>x.Regex)
				.Select(x=>
				new {
					StepDef = x,
					Regex=new Regex(x.Regex),
					Verb=x.Verb}
				).ToArray();

		
			var dicUsageCounter = allRegexes.ToDictionary(x => x, x => 0);

			foreach (var step in features.SelectMany(x => x.Scenarios).SelectMany(x => x.Steps))
			{
				var match = allRegexes.FirstOrDefault(x => x.Regex.IsMatch(step.Title) && (x.Verb==StepDefVerb.All ||  step.CalculatdVerb==x.Verb.ToString()));
				if (match==null)
				{
					step.Unmatched = true;
				}
				else
				{
					dicUsageCounter[match]++;
				}
			}

			foreach (var stepDef in dicUsageCounter.Where(x => x.Value == 0).Select(x => x.Key.StepDef))
			{
				stepDef.Unused = true;
			}
			
		}

		internal List<StepDefClass> ReadStepDefs(List<AssemblyCommentInfo> asmDocs)
		{
			Dictionary<string, StepDefVerb> dic_Attr_Verb = new Dictionary<string, StepDefVerb>();
			dic_Attr_Verb["StepDefinitionAttribute"] = StepDefVerb.All;
			dic_Attr_Verb["GivenAttribute"] = StepDefVerb.Given;
			dic_Attr_Verb["WhenAttribute"] = StepDefVerb.When;
			dic_Attr_Verb["ThenAttribute"] = StepDefVerb.Then;

			List<StepDefClass> list = new List<StepDefClass>();
			foreach (var type in asmDocs.SelectMany(x=>x.Types))
			{
	
					bool isBindingClass = type.Type.GetCustomAttributes(false).Any(x => x.GetType().FullName == "TechTalk.SpecFlow.BindingAttribute");
					if(!isBindingClass)
						continue;

					StepDefClass sc =  new StepDefClass(); 
					sc.Name = type.Name;
					sc.Namespace = type.Type.Namespace;
					sc.Comments = type.Doc.Summary;
					list.Add(sc);
					foreach (var m in type.Methods)
					{
						var attrs = m.Method.GetCustomAttributes(false).Where(attr => attr.GetType().Name == "StepDefinitionAttribute" || attr.GetType().Name == "GivenAttribute" || attr.GetType().Name == "WhenAttribute" || attr.GetType().Name == "ThenAttribute").ToList();
						if (attrs.Count != 0)
						{
							StepDefMethod sm = new StepDefMethod();

							sm.Name = m.Name;
							sm.Comments = m.Doc.Summary;
							sc.Methods.Add(sm);
							var parameters = m.Method.GetParameters();
							sm.StepDefs = attrs.Select(attr =>
							{
								var verb = StepDefVerb.All;
								verb = dic_Attr_Verb[attr.GetType().Name];

								
								var stepdef = new StepDef()
								{
									Verb = verb,
									Regex = (attr as dynamic).Regex,
									RegexWithArgName = PrintPrettyStepDefWithParameters((attr as dynamic).Regex, parameters),
									Method = sm
								};
							
								return stepdef;
							}).ToList();
						}

					}
			}

			return list;
		}

	
		/// <summary>
		/// 
		/// </summary>
		/// <param name="regex"></param>
		/// <param name="parameters"></param>
		/// <returns></returns>
		private string PrintPrettyStepDefWithParameters(string regex, ParameterInfo[] parameters)
		{
			if (parameters == null || regex == null)
				throw new ArgumentNullException();

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
				regex += "  (with table)";
			}

			if (error)
				regex += "####ERROR########";
			return regex;
		}


	}
}
