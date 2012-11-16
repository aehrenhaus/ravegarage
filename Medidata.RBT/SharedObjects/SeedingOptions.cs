using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SharedObjects
{
	public class SeedingOptions
	{
		//static Dictionary<string, bool> dic =new Dictionary<string,bool>();
		private HashSet<string> _backEndNames = new HashSet<string>();
		private HashSet<string> _suppressSeedingNames = new HashSet<string>();
		private bool _enableSeeding;

		public bool EnableSeeding
		{
			get { return _enableSeeding; }
		}

		public SeedingOptions(bool enableSeeding, string seedFromBackendClasses, string suppressSeedingClasses)
		{

			_enableSeeding = enableSeeding;

			if(seedFromBackendClasses!=null)
				foreach (var b in seedFromBackendClasses.Split(','))
					_backEndNames.Add(b.Trim());

			if (suppressSeedingClasses != null)
				foreach (var b in suppressSeedingClasses.Split(','))
				_suppressSeedingNames.Add(b.Trim());
		}


		public bool SuppressSeeding(Type type)
		{
			if (type.GetInterface(typeof(ISeedableObject).FullName) == null)
				throw new Exception("Type must inherit from ISeedableObject");
			return _suppressSeedingNames.Contains(type.Name);
		}

		public bool FromUI(Type type)
		{
			if (type.GetInterface(typeof(ISeedableObject).FullName)==null)
				throw new Exception("Type must inherit from ISeedableObject");
			return !_backEndNames.Contains(type.Name);
		}

		public bool FromUI<TSeedable>() where TSeedable:ISeedableObject
		{
			return !_backEndNames.Contains(typeof(TSeedable).Name);
		}
	}
}
