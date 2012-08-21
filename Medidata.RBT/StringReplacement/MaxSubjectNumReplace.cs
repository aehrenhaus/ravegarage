using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;

namespace Medidata.RBT
{
    class MaxSubjectNumReplace : IStringReplace
    {

        public string Replace(string[] args)
        {
			return (new NextSubjectNumReplace().GetNextSubNum(args[0], args[1], args[2])-1).ToString();
        }

		public string[] ArgsDescription
		{
			get
			{

				return new string[3] {
				"Project",
				"Environment",
				"Number Field"
			};
			}
		}

        
    }
}
