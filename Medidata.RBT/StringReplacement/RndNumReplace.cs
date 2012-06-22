using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

namespace Medidata.RBT
{
    class RndNumReplace : IStringReplace
    {

        public string Replace(string[] args)
        {
			string str = DateTime.Now.Ticks.ToString();
			int digits = int.Parse(args[0]);
			//TODO: handle the case when digits is larger than str' length
			return str.Substring(str.Length-digits);
        }

		public string[] ArgsDescription
		{
			get
			{

				return new string[1] {
				"Digits"
			};
			}
		}

        
    }
}
