using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

namespace Medidata.RBT
{
    class DateReplace : IStringReplace
    {

        public string Replace(string[] args)
        {
			return DateTime.Now.ToString("dd MMM yyyy");
        }


		public string[] ArgsDescription
		{
			get
			{

				return new string[0] {
			
			};
			}
		}
       
    }
}
