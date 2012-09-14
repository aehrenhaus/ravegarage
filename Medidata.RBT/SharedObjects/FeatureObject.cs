using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT;
using System.Reflection;

namespace Medidata.RBT.SharedObjects
{
    /// <summary>
    /// Any FeatureObject exists throughout the life of the feature file.
    /// </summary>
    public class FeatureObject
    {
        /// <summary>
        /// This needs to exist for the abstract class to exist, don't call this constructor
        /// </summary>
        public FeatureObject()
        {
            throw new Exception("You should never call this constructor");
        }

        /// <summary>
        /// This constructor will automatically fetch the feature object if it is already created and set the object properties using reflection.
        /// </summary>
        /// <param name="featureName">The name of the object in the feature file</param>
        /// <param name="objectFields"></param>
        public FeatureObject(string featureName, List<FieldInfo> objectFields)
        {
            FeatureObject existingFieldObject;
            TestContext.FeatureObjects.TryGetValue(featureName, out existingFieldObject);

            if (existingFieldObject != null)
            {
                if(objectFields == null)
                    objectFields = new List<FieldInfo>();
                objectFields.AddRange(this.GetType().GetFields(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance).ToList());

                foreach (FieldInfo fi in objectFields)
                    fi.SetValue(this, fi.GetValue(existingFieldObject));
            }
        }
    }
}
