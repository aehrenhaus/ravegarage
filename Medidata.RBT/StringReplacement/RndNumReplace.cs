using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;

namespace Medidata.RBT
{
    class RndNumReplace : IStringReplace
    {
		Random rnd = new Random();
        public string Replace(string[] args)
        {
			int digits = int.Parse(args[0]);
			int startNum = (int)Math.Pow(10, digits-1);
			int endNum = (int)Math.Pow(10, digits)-1;
			int num = rnd.Next(startNum,endNum);
			
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
