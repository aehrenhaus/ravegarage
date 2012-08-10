using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT
{
	public interface ICanVerifyExist: IPage
	{

		bool VerifyTableRowsExist(string tableIdentifier, Table matchTable);

		bool VerifyControlExist(string identifier);

		bool VerifyTextExist(string identifier, string text);
	}
}
