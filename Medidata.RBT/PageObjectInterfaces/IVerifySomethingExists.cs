
namespace Medidata.RBT
{

	public interface IVerifySomethingExists 
	{
		bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false);
	}
}
