using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    public interface IPositionCursor
    {
        /// <summary>
        /// This interface can be used to position cursor for elements such text area
        /// at the start of matching text.
        /// </summary>
        /// <param name="matchText">identifier the text to match</param>
        /// /// <param name="areaIdentifier">identifies the area for placing cursor</param>
        void PositionCursorAtStart(string matchText, string areaIdentifier);

        /// <summary>
        /// This interface can be used to position cursor for elements such text area
        /// at the end of matching text.
        /// </summary>
        /// <param name="matchText">identifier the text to match</param>
        /// <param name="areaIdentifier">identifies the area for placing cursor</param> 
        void PositionCursorAtEnd(string matchText, string areaIdentifier);
    }
}
