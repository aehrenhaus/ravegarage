using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;

namespace Medidata.RBT
{
	/// <summary>
	/// See IPageObjectFactory interface
	/// </summary>
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
		    Dictionary<string, Type> urls = new Dictionary<string, Type>();

			foreach (var poType in types.Where(x => x.GetInterface("IPage") != null && !x.IsAbstract))
			{
                if(dicNameType.ContainsKey(poType.Name))
                {
                    throw new Exception("Already add a PO class that has UniqueName "+poType.Name);
                }

                
			    dicNameType[poType.Name] = poType;
			
                IPage po2 = Activator.CreateInstance(poType) as IPage;
                if (urls.ContainsKey(po2.URL))
                    throw new Exception(string.Format("Already add a PO {0} that has url {1}", urls[po2.URL].Name, po2.URL));
			    urls.Add(po2.URL,poType);
                pos.Add(po2);
			 
			}

		}

		#region IPageObjectFactory

		/// <summary>
		/// See IPageObjectFactory interface
		/// </summary>
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

		/// <summary>
		/// See IPageObjectFactory interface
		/// </summary>
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
            return new EmptyPage(); // change needed so that url paths that don't have their own classes DO NOT throw an exception.  
                                    //...                      (made after conversations with Zhan)

        }

		#endregion
	}
}
