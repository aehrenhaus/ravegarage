using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;

namespace Medidata.RBT
{
	/// <summary>
	/// Retrive the variable saved earlier
	/// 
	/// The string replacement mechanism has the ability to save the replaced string to a 'variable' 
	/// so that it can be used later.
	/// 
	/// For example
	/// <![CDATA[
	/// if you create a suject 'sub {RndNum<subnum>(5)'
	/// this will be replaced to sub 13461 , and the replaced number will be saved to a variable called subnum
	/// 
	/// later if you want to use the varible when you select a subject, you can use
	/// I select subject 'sub {Var(subnum)}'
	/// ]]>
	/// </summary>
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
