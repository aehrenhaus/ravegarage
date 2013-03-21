
using System.Collections.Generic;
namespace Medidata.RBT
{
    /// <summary>
    /// Interface to verify that something exists on a page
    /// </summary>
	public interface IVerifySomethingExists 
	{
        /// <summary>
        /// Verify that something exists on a page
        /// </summary>
        /// <param name="areaIdentifier">The area the object must exist in</param>
        /// <param name="type">The type of object</param>
        /// <param name="identifier">The identifier of the object</param>
        /// <param name="exactMatch">Whether the object must be an exact match, or only conain part of the id</param>
        /// <param name="amountOfTimes">The amount of times the object should exist in the area, if it is null it must exist at least once</param>
        /// <param name="bold">The object identified should be bold</param>
        /// <param name="pdf">The pdf to check, if checking a pdf and not a page</param>
        /// <returns>True if the object exists, false if not</returns>
        bool VerifySomethingExist(string areaIdentifier, string type, string identifier, bool exactMatch = false, int? amountOfTimes = null, RBT.BaseEnhancedPDF pdf = null, bool? bold = null);

        /// <summary>
        /// Verify list of objects exist on a page
        /// </summary>
        /// <param name="type">The type of object</param>
        /// <param name="identifier">The identifiers of the objects</param>
        /// <param name="exactMatch">Whether the object must be an exact match, or only conain part of the id</param>
        /// <param name="amountOfTimes">The amount of times the object should exist in the area, if it is null it must exist at least once</param>
        /// <param name="bold">The object identified should be bold</param>
        /// <param name="pdf">The pdf to check, if checking a pdf and not a page</param>
        /// <returns>True if the objects exist, false if not</returns>
        bool VerifySomethingExist(string areaIdentifier, string type, List<string> identifiers, bool exactMatch = false, int? amountOfTimes = null, RBT.BaseEnhancedPDF pdf = null, bool? bold = null);
	}
}
