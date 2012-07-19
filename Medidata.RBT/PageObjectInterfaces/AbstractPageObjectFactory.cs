using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;

namespace Medidata.RBT.PageObjects.Rave
{
	public abstract class AbstractPageObjectFactory : IPageObjectFactory
	{
		public AbstractPageObjectFactory()
		{

		}

		protected abstract Assembly[] GetContainingAssemblies();

		private Dictionary<string, Type> dicNameType; //name and IPage type
		private List<IPage> pos;

		private void Initialize()
		{

			dicNameType = new Dictionary<string, Type>();
			pos = new List<IPage>();


			IEnumerable<Type> types = GetContainingAssemblies().SelectMany(x => x.GetTypes());

			foreach (var poType in types.Where(x => x.GetInterface("IPage") != null))
			{
				dicNameType[poType.Name] = poType;
				IPage po2 = Activator.CreateInstance(poType) as IPage;
				pos.Add(po2);
				
			}

		}

		public IPage GetPage(string className) 
		{
			if (dicNameType == null || pos == null)
			{
				Initialize();
			}

			if (!className.EndsWith("Page"))
				className += "Page";

			if (!dicNameType.ContainsKey(className))
				throw new Exception("Page class not found:"+className);

			var po = Activator.CreateInstance(dicNameType[className]) as IPage;

			return po;
		}


		public virtual IPage GetPageByUrl(Uri uri)
		{
			if (dicNameType == null || pos == null)
			{
				Initialize();
			}

			foreach (var po in pos)
			{
				bool isThePage = false;
				try
				{
					isThePage = po.IsThePage();

				}
				catch{
				}
                if (isThePage)
                {
                    //instead of return po, create a new instance. 
                    return Activator.CreateInstance(po.GetType()) as IPage;
                }
			}
            return new PageBase();
        }
	}
}
