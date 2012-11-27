using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT
{
	public interface IVerifyRowsExist
	{

		bool VerifyTableRowsExist(string tableIdentifier, Table matchTable);

	}

	public interface IVerifySomethingExists 
	{
		bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false);
	}
}
