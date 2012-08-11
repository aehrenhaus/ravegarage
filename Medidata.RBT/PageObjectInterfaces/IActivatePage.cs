using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
	public interface IActivatePage : IPage
	{
		IPage Activate(string type, string identifierToActivate);
		IPage Inactivate(string type, string identifierToInactivate);
	}
}
