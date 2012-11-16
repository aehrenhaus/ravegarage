using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SharedObjects
{
	public interface ISeedableObject 
	{
		bool SuppressSeeding { get; set; }
		string UniqueName{ get; set; }
		void Seed();
	}

}
