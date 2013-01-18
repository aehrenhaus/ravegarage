using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT
{
    public static class Factory
    {
        private static List<IRemoveableObject> m_ScenarioObjectsForDeletion;
        /// <summary>
        /// The list of removable objects that will be deleted upon scenario end.
        /// </summary>
        public static List<IRemoveableObject> ScenarioObjectsForDeletion
        {
            get
            {
                if (m_ScenarioObjectsForDeletion == null)
                    m_ScenarioObjectsForDeletion = new List<IRemoveableObject>();

                return m_ScenarioObjectsForDeletion;
            }
            set
            {
                m_ScenarioObjectsForDeletion = value;
            }
        }

        private static List<IRemoveableObject> m_FeatureObjectsForDeletion;
        /// <summary>
        /// The list of removable objects that will be deleted upon scenario end.
        /// </summary>
        public static List<IRemoveableObject> FeatureObjectsForDeletion
        {
            get
            {
                if (m_FeatureObjectsForDeletion == null)
                    m_FeatureObjectsForDeletion = new List<IRemoveableObject>();

                return m_FeatureObjectsForDeletion;
            }
            set
            {
                m_FeatureObjectsForDeletion = value;
            }
        }


        /// <summary>
        /// Delete objects that were marked for deletion over the course of the scenario
        /// </summary>
        /// <returns></returns>
        public static void DeleteObjectsMarkedForScenarioDeletion()
        {
            foreach (IRemoveableObject obj in ScenarioObjectsForDeletion)
                obj.DeleteSelf();

            ScenarioObjectsForDeletion = new List<IRemoveableObject>();
        }

        /// <summary>
        /// Delete objects that were marked for deletion over the course of the scenario
        /// </summary>
        /// <returns></returns>
        public static void DeleteObjectsMarkedForFeatureDeletion()
        {
            foreach (IRemoveableObject obj in FeatureObjectsForDeletion)
                obj.DeleteSelf();

            FeatureObjectsForDeletion = new List<IRemoveableObject>();
        }
    }
}