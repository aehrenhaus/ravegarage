
using TechTalk.SpecFlow;

namespace Medidata.RBT
{
	public interface IVerifyRowsExist
	{

		bool VerifyTableRowsExist(string tableIdentifier, Table matchTable);

	}
}
