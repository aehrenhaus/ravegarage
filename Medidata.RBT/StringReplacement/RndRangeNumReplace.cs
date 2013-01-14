using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;

namespace Medidata.RBT
{
    class RndRangeNumReplace : IStringReplace
    {
		Random rnd = new Random();
        public string Replace(string[] args)
        {
			int min = int.Parse(args[0]);
			int max = int.Parse(args[1]);
			return rnd.Next(min,max+1).ToString();
        }

		public string[] ArgsDescription
		{
			get
			{

				return new string[] {
					"Min",
					"Max"
			};
			}
		}

        
    }
}
