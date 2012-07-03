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
			
			long num = int.Parse( str.Substring(str.Length-digits));
			//make sure it does not start with a 0. 
			while (num < Math.Pow(10, digits-1))
				num *= 10;
			return num.ToString();
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
