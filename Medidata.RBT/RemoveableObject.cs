using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
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
