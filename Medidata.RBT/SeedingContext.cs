using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;
using System.Collections;
using Medidata.RBT.ConfigurationHandlers;

namespace Medidata.RBT
{
	public class SeedingContext
	{
		static SeedingContext()
		{
			SeedableObjects = new Dictionary<string, ISeedableObject>();
		}
		
		/// <summary>
		/// Mapping of the name provided in the feature file to the FeatureObject object created by the FeatureObject constructor.
		/// </summary>
		public static Dictionary<string, ISeedableObject> SeedableObjects { get; set; } 


		/// <summary>
		/// Method to either get a FeatureObject that already exists in the FeatureObjects dictionary.
		/// Or, call that object's constructor to make a new one and add that to the FeatureObjects dictionary.
		/// </summary>
		/// <typeparam name="T">A feature object type</typeparam>
		/// <param name="originalName">The feature name of the object, the name the object is referred to as in the feature file.</param>
		/// <param name="constructor">The delegate of the call to the constructor</param>
		/// <returns></returns>
		public static T GetExistingFeatureObjectOrMakeNew<T>(string originalName, Func<T> constructor) where T : ISeedableObject
		{
			ISeedableObject seedable;
			SeedableObjects.TryGetValue(originalName, out seedable);

			if (seedable != null)
				return (T)seedable;

			seedable = constructor();
			if (seedable == null)
				return default(T);

            if (RBTConfiguration.Default.EnableSeeding)
			    seedable.Seed();

			//add to dictionary using both original name and unique name.
			SeedableObjects[originalName] = seedable;
			SeedableObjects[seedable.UniqueName] = seedable;

			return (T)seedable;
		}

        /// <summary>
        /// Method to get a FeatureObject that already exists
        /// </summary>
        /// <typeparam name="T">A feature object typ</typeparam>
        /// <param name="originalName">The feature name of the object, the name the object is referred to as in the feature file.</param>
        /// <returns></returns>
        public static T TryGetExistingFeatureObject<T>(string originalName) where T : ISeedableObject
        {
            ISeedableObject seedable = null;

            SeedableObjects.TryGetValue(originalName, out seedable);

            return seedable == null ? default(T) : (T)seedable;
        }

	}
}
