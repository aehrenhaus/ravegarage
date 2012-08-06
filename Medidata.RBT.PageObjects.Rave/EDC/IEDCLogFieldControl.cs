using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    public interface IEDCLogFieldControl
        : IEDCFieldControl
    {
        /// <summary>
        /// Determines whether or not a high level Rave EDC element, defined by ControlType enum,
        /// has focus. An EDC field can be composed of many elements so it is necessary to also specify the ordinal of the 
        /// type in question.
        /// </summary>
        /// <param name="type">High level Rave element type</param>
        /// <param name="position">The ordinal of the element in the composite field</param>
        /// <returns></returns>
        bool IsElementFocused(ControlType type, int position);
        /// <summary>
        /// Sets focus to a high level Rave EDC element, defined by ControlType enum.
        /// An EDC field can be composed of many elements so it is necessary to also specify the ordinal of the 
        /// type in question.
        /// </summary>
        /// <param name="type">High level Rave element type</param>
        /// <param name="position">The ordinal of the element in the composite field</param>
        void FocusElement(ControlType type, int position);
    }
}
