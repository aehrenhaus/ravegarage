using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SharedObjects
{
	public interface ISeedableObject : IFeatureObject
	{
		bool SuppressSeeding { get; set; }

		Guid? UID { get; set; }

		string Name { get; set; }

		//A unique name of the SeedableObject, usually formed using the name + TID
		string UniqueName{ get; set; }


		//void SeedFromUI();

		//void SeedFromBackend();


		/// <summary>
		/// Seed the seedable object.
		/// All uploads are done logging in with the default user.
		/// Note the user logged in before that seed. At the end of the seed, this user is logged in again and we return to the HomePage.
		/// </summary>
		void Seed();
	}

}
