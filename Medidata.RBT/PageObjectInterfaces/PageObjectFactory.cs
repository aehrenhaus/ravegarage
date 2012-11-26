using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;

namespace Medidata.RBT
{
	public class PageObjectFactory
	{
		public PageObjectFactory()
		{
		}

		public void AddAssembly(Assembly assembly)
		{
			_assemblies.Add(assembly);
			var newTypes = assembly.GetTypes().Where(x => x.GetInterface("IPage") != null && !x.IsAbstract);
			_types.AddRange(newTypes);


			foreach (var poType in newTypes)
			{
				if (_dicNameType.ContainsKey(poType.Name))
				{
					throw new Exception("Already add a PO class that has Name " + poType.Name);
				}
				_dicNameType[poType.Name] = poType;

				IPage po2 = Activator.CreateInstance(poType) as IPage;

				string url = po2.BaseURL + po2.URL;
				if (urls.ContainsKey(url))
					throw new Exception(string.Format("Already add a PO {0} that has url {1}", urls[url].Name, po2.URL));

				urls.Add(url, poType);
				_pageObjects.Add(po2);

			}

		}

		private List<Assembly> _assemblies = new List<Assembly>();
		private List<Type> _types = new List<Type>();
		private Dictionary<string, Type> _dicNameType = new Dictionary<string, Type>();
		private List<IPage> _pageObjects = new List<IPage>();
		Dictionary<string, Type> urls = new Dictionary<string, Type>(); // just for url duplicity check

		public IPage GetPage(string className)
		{
			if (!_dicNameType.ContainsKey(className))
				throw new Exception("Page class not found: " + className);

			var po = Activator.CreateInstance(_dicNameType[className]) as IPage;

			return po;
		}

		public virtual IPage GetPageByUrl(Uri uri)
		{
			foreach (var po in _pageObjects)
			{
				bool isThePage = false;
				try
				{
					isThePage = po.IsThePage();

				}
				catch
				{
				}
				if (isThePage)
				{
					//instead of return po, create a new instance. 
					return Activator.CreateInstance(po.GetType()) as IPage;
				}
			}


			return new GeneralPage();
		}
	}
}
