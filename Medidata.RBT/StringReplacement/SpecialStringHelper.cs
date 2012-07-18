using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;
using TechTalk.SpecFlow;

namespace Medidata.RBT
{
    public class SpecialStringHelper
    {
		static Dictionary<string, IStringReplace> allReplaces = new Dictionary<string, IStringReplace>();

        static SpecialStringHelper()
        {
            var iStringReplaceTypes = typeof(SpecialStringHelper).Assembly.GetTypes().Where(t => t.GetInterface("IStringReplace") != null);
            foreach (Type type in iStringReplaceTypes)
            {
				string replaceName = type.Name.Replace("Replace","");
				allReplaces.Add(replaceName, Activator.CreateInstance(type) as IStringReplace);
            }
        }

        public static string Replace(string input)
        {
			Regex reg = new Regex(@"{(?<name>.+?)(\<(?<var>.+?)\>)?\((?<args>.*)?\)}");
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
						TestContext.Vars[var] = replaced;
					}
					return replaced;
				});

			if (input != output)
			{
				Console.WriteLine("replace --> " + input+ " --> " + output);
			}

			return output;
        }

		public static void SetVar(string varName, string value)
		{
			TestContext.Vars[varName] = value;
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
