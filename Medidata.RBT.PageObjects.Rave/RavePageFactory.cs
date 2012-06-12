using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class RavePageFactory
	{
		static Dictionary<string, Type> pageObjectTypes;

		public static IPage GetPage(string className) 
		{
			if (pageObjectTypes == null)
			{
				pageObjectTypes = new Dictionary<string, Type>();
				foreach (var poType in typeof(RavePageFactory).Assembly.GetTypes().Where(x => x.GetInterface("IPage")!=null))
				{

					pageObjectTypes[poType.Name] = poType;
				}
			}

			if (!className.EndsWith("Page"))
				className += "Page";

			if (!pageObjectTypes.ContainsKey(className))
				throw new Exception("Page class not found:"+className);

			var po = Activator.CreateInstance(pageObjectTypes[className]) as IPage;

			return po;
		}
	}
}
