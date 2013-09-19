using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    /// <summary>
    /// Custom wrapper around the TechTalk.SpecFlow.Assist.TableHelperExtensionMethods extension methods to allow us to do pre-processing on the table.
    /// </summary>
    public static class SpecFlowHelper
    {
        //methods we aren't wrapping yet
        //public static T CreateInstance<T>(this Table table);
        //public static T CreateInstance<T>(this Table table, Func<T> methodToCreateTheInstance);
        //public static IEnumerable<T> CreateSet<T>(this Table table, Func<T> methodToCreateEachInstance);
        //public static void FillInstance<T>(this Table table, T instance);

        /// <summary>
        /// Custom wrapper around the CreateSet method that does processing. For example, boundary quotes are stripped.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="table"></param>
        /// <returns></returns>
        public static IEnumerable<T> CustomCreateSet<T>(this Table table)
        {
            StripQuotesAtBoundariesForTableValues(table);

            return table.CreateSet<T>();
        }


        public static string PrepareString(string raw)
        {
            return StripQuotesAtBoundaries(raw);
        }

        /// <summary>
        /// Removes leading and trailing quotes from all of a table's values.
        /// </summary>
        /// <param name="table"></param>
        public static void StripQuotesAtBoundariesForTableValues(Table table)
        {
            table.Rows.ToList().ForEach(row => row.Keys.ToList().ForEach(key =>
            {
                var raw = row[key];

                var cleaned = StripQuotesAtBoundaries(raw);

                if (cleaned != raw)
                    row[key] = cleaned;
            }));
        }

        public static string StripQuotesAtBoundaries(string raw)
        {
            const char delimiter = '"';

            if (string.IsNullOrEmpty(raw)) return raw;

            var result = raw;

            if (result[0] == delimiter)
                result = result.Substring(1, result.Length - 1);

            if (result[result.Length - 1] == delimiter)
                result = result.Substring(0, result.Length - 1);

            return result;
        }
    }
}
