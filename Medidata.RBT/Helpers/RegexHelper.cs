using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Medidata.RBT.Helpers
{
    public static class RegexHelper
    {
        /// <summary>
        /// Get regex to find a date with the passed in datetime format
        /// </summary>
        /// <param name="dateTimeFormat">The datetime format</param>
        /// <returns>The regex to find a date with that string</returns>
        public static string GetRegexFromDateTimeFormat(string dateTimeFormat)
        {
            dateTimeFormat = dateTimeFormat.Replace("dd", "[0-3][0-9]");
            dateTimeFormat = dateTimeFormat.Replace("MMM", "[JFMASOND][aepuco][nbrynlgptvc]");
            dateTimeFormat = dateTimeFormat.Replace("yyyy", "[0-9][0-9][0-9][0-9]");
            dateTimeFormat = dateTimeFormat.Replace("HH", "[0-2][0-9]");
            dateTimeFormat = dateTimeFormat.Replace("mm", "[0-5][0-9]");
            dateTimeFormat = dateTimeFormat.Replace("ss", "[0-5][0-9]");

            return dateTimeFormat;
        }
    }
}
