using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedRaveObjects;
using System.Data;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	/// <summary>
	/// Provides a representation of Coding Dictionary managed by the Medidata Coder system
	/// </summary>
	public class CodingDictionary :
		BaseCodingDictionary
	{
		public override bool IsCoderDict { get { return true; } }
		
		public List<ProjectCoderRegistration> ProjectCoderRegistrations { get; private set; }
		public CodingColumnList CodingColumns { get; private set; }


		public CodingDictionary(string codingDictionaryName, string dictionaryVersion)
			:base(codingDictionaryName, dictionaryVersion)
		{
			this.ProjectCoderRegistrations = new List<ProjectCoderRegistration>();
			this.CodingColumns = new CodingColumnList();
		}


		public CodingColumn GetCodingColumn(string codingColumnName) 
		{ 
			return this.CodingColumns
				.FirstOrDefault((cc) => cc.CodingColumnName.Equals(codingColumnName)); 
		}

		public class CodingColumnList : List<CodingColumn>
		{
			private HashSet<string> _codingColumnNameSet = new HashSet<string>();

			public new void Add(CodingColumn codingColumn)
			{
				_codingColumnNameSet.Add(codingColumn.CodingColumnName);
				base.Add(codingColumn);
			}
			public new void AddRange(IEnumerable<CodingColumn> l) 
			{
				foreach(var codingColumn in l)
					if (!_codingColumnNameSet.Contains(codingColumn.CodingColumnName))
						this.Add(codingColumn);
			}
		}
	}
}
