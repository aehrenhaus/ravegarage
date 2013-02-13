using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
	public class ClassicCodingDictionary :
		BaseCodingDictionary
	{
		public override bool IsCoderDict { get { return false; } }

		public ClassicCodingDictionary(string codingDictionaryName, string dictionaryVersion)
			: base(codingDictionaryName, dictionaryVersion)
		{ }
	}
}
