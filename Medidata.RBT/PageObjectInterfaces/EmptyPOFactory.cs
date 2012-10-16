using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;

namespace Medidata.RBT
{
	public class EmptyPOFactory : AbstractPageObjectFactory
	{
		protected override System.Reflection.Assembly[] GetContainingAssemblies()
		{
			return new Assembly[0] { };
		}
	}
}
