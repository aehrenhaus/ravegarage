using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    /// <summary>
    ///All objects which require cleanup at the end of a scenario should implement this class. 
    ///The removeable objects should be marked for deletion when created, then are cleared down at scenario.
    ///The objects that inherit off of this should know how to delete themselves as the DeleteSelf method will be called for each object marked for deletion.
    ///</summary>
    public class RemoveableObject
    {
        /// <summary>
        /// Deletes information on that page created during the scenario
        /// </summary>
        /// <returns></returns>
        public virtual void DeleteSelf()
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Mark the RemoveableObject for deletion at the end of the scenario
        /// </summary>
        /// <returns></returns>
        public virtual void MarkForDeletion()
        {
            TestContext.ObjectsForDeletion.Add(this);
        }
    }
}
