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
        static List<IStringReplace> allReplaces = new List<IStringReplace>();

        static SpecialStringHelper()
        {
            var iStringReplaceTypes = typeof(SpecialStringHelper).Assembly.GetTypes().Where(t => t.GetInterface("IStringReplace") != null);
            foreach (Type type in iStringReplaceTypes)
            {
                allReplaces.Add(Activator.CreateInstance(type) as IStringReplace);
            }
        }

        public static string Replace(string input)
        {
            foreach (var stringReplace in allReplaces)
            {
                input = stringReplace.Replace(input);
            }
            return input;
        }


    }
}
