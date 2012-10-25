using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SharedObjects
{
	public static class SeedDecision
	{
		//static Dictionary<string, bool> dic =new Dictionary<string,bool>();
		static HashSet<string> _backEndNames = new HashSet<string>();


		static SeedDecision()
		{
			string[] back = RBTConfiguration.Default.SeedFromBackendClasses.Split(',');
			//string[] ui = RBTConfiguration.Default.SeedFromUIClasses.Split(',');

			foreach (var b in back)
				_backEndNames.Add(b.Trim());
		}


		public static bool FromUI(Type type)
		{
			if (type.GetInterface(typeof(ISeedableObject).FullName)==null)
				throw new Exception("Type must inherit from ISeedableObject");
			return !_backEndNames.Contains(type.Name);
		}

		public static bool FromUI<TSeedable>() where TSeedable:ISeedableObject
		{
			return !_backEndNames.Contains(typeof(TSeedable).Name);
		}
	}
}
