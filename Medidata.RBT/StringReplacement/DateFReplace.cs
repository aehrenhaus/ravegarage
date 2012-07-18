using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

namespace Medidata.RBT
{
	/// <summary>
	/// Date with format
	/// </summary>
    class DateFReplace : IStringReplace
    {

        public string Replace(string[] args)
        {
			int dayDiff = int.Parse(args[0]);
			string format = args[1];
			return DateTime.Today.AddDays(dayDiff).ToString(format);
        }


		public string[] ArgsDescription
		{
			get
			{

				return new string[2] { 
					"Day difference from today",
					"Format"
			
			};
			}
		}
       
    }
}
