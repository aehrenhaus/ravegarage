using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

namespace Medidata.RBT
{
    class VarReplace : IStringReplace
    {

        public string Replace(string[] args)
        {
			return TestContext.Vars[args[0]];
        }


		public string[] ArgsDescription
		{
			get
			{

				return new string[1] {
				"Variable name"
			};
			}
		}
       
    }
}
