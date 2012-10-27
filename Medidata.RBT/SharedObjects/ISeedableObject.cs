using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SharedObjects
{
	public interface ISeedableObject : IFeatureObject
	{
		bool SuppressSeeding { get; set; }

		//Derived from Name property and some other value, to make name different everytime it seeds
		string UniqueName{ get; set; }

		void Seed();
	}

}
