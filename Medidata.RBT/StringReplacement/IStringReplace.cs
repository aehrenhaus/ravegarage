using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	/// <summary>
	/// This interface provides methods that is used in StringReplacement
	/// Example scenario:
	/// When writing Gherkin setp: 
	///		Then I create Subject 'Sub{RndNum(3)}'
	/// you want to replace {RndNum(3)} with a 3 digit random number
	/// 
	/// 
	/// For more details, please see readme.txt and the project document on medinet
	/// </summary>
    public interface IStringReplace
    {
		/// <summary>
		/// The method that do the replace
		/// example: relpace {RndNum(5)} to 43570
		/// replace {Date(0)} to 02-May-2012
		/// </summary>
		/// <param name="args"></param>
		/// <returns></returns>
        string Replace(string[] args);

		/// <summary>
		/// Describe each argument that Replace() method takes
		/// </summary>
		string[] ArgsDescription { get; }
    }
}
