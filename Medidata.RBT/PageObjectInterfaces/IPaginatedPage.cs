using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	public interface IPaginatedPage : IPage
	{
		IPage GoNextPage();
		IPage GoPreviousPage();
		IPage GoToPage(int page);
	}
}
