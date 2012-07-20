using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT
{
	public interface IVerifyDisableControlsPage: IPage
	{
		bool ControlsAreDisabled(Table table);
	}
}
