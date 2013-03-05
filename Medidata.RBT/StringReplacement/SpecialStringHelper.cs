using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using TechTalk.SpecFlow;
using System.Reflection;
using System.Collections.Specialized;

namespace Medidata.RBT
{
	/// <summary>
	/// All the string replacement shall be done throught calling SpecialStringHelper.Replace()
	/// 
	/// 
	/// </summary>
    public class SpecialStringHelper
    {

		public static NameValueCollection StringReplacementVars { get; set; }


		public static event Action<string, string> Replaced;

		static Dictionary<string, IStringReplace> allReplaces = new Dictionary<string, IStringReplace>();

        static SpecialStringHelper()
        {
			StringReplacementVars = new NameValueCollection();
	        foreach (var assembly in Directory.GetFiles(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),"*.dll"))
	        {
				RegisterStringReplaceAssembly(Assembly.LoadFile(assembly));
	        }
	        
        }

		private static void RegisterStringReplaceType(Type type)
		{
			string replaceName = type.Name.Replace("Replace", "");
			allReplaces.Add(replaceName, Activator.CreateInstance(type) as IStringReplace);
		}

		/// <summary>
		/// Register string replacement class outside of this assembly
		/// </summary>
		/// <typeparam name="TReplace"></typeparam>
		public static void RegisterStringReplaceType<TReplace>() where TReplace : IStringReplace
		{
			RegisterStringReplaceType(typeof(TReplace));
		}

		/// <summary>
		/// Register string replacement class outside of this assembly
		/// </summary>
		/// <param name="assembly"></param>
		public static void RegisterStringReplaceAssembly(Assembly assembly) 
		{
			var iStringReplaceTypes = assembly.GetTypes().Where(t => t.GetInterface("IStringReplace") != null); ;
			foreach (Type type in iStringReplaceTypes)
			{
				string replaceName = type.Name.Replace("Replace", "");
				allReplaces.Add(replaceName, Activator.CreateInstance(type) as IStringReplace);
			}
		}

		/// <summary>
		/// This method will scan the input to see if the special pattern exists.
		/// See readme.txt or medinet document of this project
		/// 
		/// If the pattern exists in the input, it will extract the 3 components:
		///		replacement method name
		///		arguments
		///		variable name
		///	And it will find a matching IStringReplace object and do the actual replacement
		///	
		/// 
		/// </summary>
		/// <param name="input"></param>
		/// <returns></returns>
        public static string Replace(string input)
        {   
			Regex reg = new Regex(@"{(?<name>.+?)(\<(?<var>.+?)\>)?\((?<args>.*?)?\)}");
			var output = reg.Replace(input, m =>
				{
					string name = m.Groups["name"].Value;
					string[] args = m.Groups["args"].Value.Split(new char[]{','}, StringSplitOptions.RemoveEmptyEntries);
					string var = m.Groups["var"].Value;

					IStringReplace replaceMethod = null;
					if (allReplaces.ContainsKey(name))
						replaceMethod = allReplaces[name];

					if (replaceMethod == null)
						throw new Exception("Replace method not found: " + name);



					if (replaceMethod.ArgsDescription.Length != args.Length)
					{
						throw new Exception("Replace method arguments count not match: " + name+". Required arguments:"+string.Join(",",replaceMethod.ArgsDescription));
					}
					var replaced  = replaceMethod.Replace(args);

					if (!string.IsNullOrWhiteSpace(var))
					{
						StringReplacementVars[var] = replaced;
					}
					return replaced;
				});

			if (input != output)
			{
				if (Replaced != null)
					Replaced(input, output);
			}

			return output;
        }

		public static void SetVar(string varName, string value)
		{
			SpecialStringHelper.StringReplacementVars[varName] = value;
		}

		public static Table ReplaceTable(Table table)
		{
			foreach (var row in table.Rows)
			{
				foreach (var col in table.Header)
					row[col] = Replace(row[col]);
			}
			return table;
		}

		public static Table ReplaceTableColumn(Table table, string colName)
		{
			foreach (var row in table.Rows)
			{
				row[colName] = Replace(row[colName]);
			}
			return table;
		}
    }
}
