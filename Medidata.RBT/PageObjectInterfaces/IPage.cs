using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	public interface IPage
	{
		TPage As<TPage>() where TPage : class, IPage;
		string URL { get; }
	}
}
