using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;

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
			input = reg.Replace(input, m =>
				{
					string name = m.Groups["name"].Value;
					string[] args = m.Groups["args"].Value.Split(',');
					string var = m.Groups["var"].Value;

					IStringReplace replaceMethod = null;
					if (allReplaces.ContainsKey(name))
						replaceMethod = allReplaces[name];

					if (replaceMethod == null)
						throw new Exception("Replace method not found: " + name);
					if (replaceMethod.ArgsCount != args.Length)
						throw new Exception("Replace method arguments count not match: " + name);
					var replaced  = replaceMethod.Replace(args);

					if (!string.IsNullOrWhiteSpace(var))
					{
						TestContext.Vars[var] = replaced;
					}
					return replaced;
				});

            return input;
        }


    }
}
