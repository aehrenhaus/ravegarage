using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;

namespace Medidata.RBT
{
	/// <summary>
	/// Return a number that increase/decrease everytime.
	/// </summary>
    public class IncreaseNumReplace : IStringReplace
    {
		public static void Reset()
		{
			_set = false;
			_initialNum = 0;
			_step = 0;
			_currentNum = 0;
			_digit = 0;
		}

		private static bool _set;
		private static int _initialNum;
		private static int _step;
		private static int _currentNum;
		private static int _digit;

		public string Replace(string[] args)
        {
			if (!_set)
			{
				_set = true;
				_initialNum = int.Parse(args[0]);
				_step = int.Parse(args[1]);
				_digit = int.Parse(args[2]);
				_currentNum = _initialNum;
			}
			string ret = _currentNum.ToString(new string('0',_digit));
			_currentNum += _step;
			return ret;
        }


		public string[] ArgsDescription
		{
			get
			{

				return new string[3] {
				"Initial number",
				"Increase step",
				"Digit of number(0 padding)"
			};
			}
		}
       
    }
}
