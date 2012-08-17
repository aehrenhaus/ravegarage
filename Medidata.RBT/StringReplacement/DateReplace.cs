using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;

namespace Medidata.RBT
{
	/// <summary>
	/// Date
	/// </summary>
    class DateReplace : IStringReplace
    {
		public string Replace(string[] args)
		{
			int dayDiff = int.Parse(args[0]);

			return DateTime.Today.AddDays(dayDiff).ToString("dd MMM yyyy");
		}


		public string[] ArgsDescription
		{
			get
			{

				return new string[] { 
					"Day difference from today"
			
			};
			}
		}
       
    }
}
