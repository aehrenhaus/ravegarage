using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	public interface IPageObjectFactory
	{
		/// <summary>
		/// Get page object instance by class name.
		/// 
		/// </summary>
		/// <param name="className"></param>
		/// <returns></returns>
		IPage GetPage(string className);

		/// <summary>
		/// Get page object instance by the actual url in browser
		/// This will use the URL property of IPage to do the matching.
		/// </summary>
		/// <param name="uri"></param>
		/// <returns></returns>
		IPage GetPageByUrl(Uri uri);
	}
}
