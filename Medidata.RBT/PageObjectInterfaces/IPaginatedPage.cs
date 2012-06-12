using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	public interface IPaginatedPage : IPage
	{
		PageBase GoNextPage();
		PageBase GoPreviousPage();
		PageBase GoToPage(int page);
	}
}
