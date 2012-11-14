using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	public interface IHavePaginationControl
	{
		ICanPaginate GetPaginationControl(string areaIdentifier);
	}
}
