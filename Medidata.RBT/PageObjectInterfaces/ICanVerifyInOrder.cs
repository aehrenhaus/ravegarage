using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Medidata.RBT
{
	public interface ICanVerifyInOrder: IPage
	{
		/// <summary>
		/// In the order of the given match table (1-* columns)
		/// </summary>
		/// <param name="tableIdentifier"></param>
		/// <param name="matchTable"></param>
		/// <returns></returns>
		bool VerifyTableRowsInOrder(string tableIdentifier, Table matchTable);

		/// <summary>
		/// 1 column is in alphabetical order
		/// </summary>
		/// <param name="tableIdentifier"></param>
		/// <param name="columnName"></param>
		/// <returns></returns>
		bool VerifyTableColumnInAphabeticalOrder(string tableIdentifier, string columnName, bool asc);

		/// <summary>
		/// 
		/// </summary>
		/// <param name="tableIdentifier"></param>
		/// <param name="hasHeader"></param>
		/// <returns></returns>
		bool VerifyTableInAphabeticalOrder(string tableIdentifier, bool hasHeader, bool asc);



		/// <summary>
		/// Things in order, the meaning of this method will depend on concrete page.
		/// </summary>
		/// <param name="identifier"></param>
		/// <returns></returns>
		bool VerifyThingsInOrder(string identifier);
	}
}
