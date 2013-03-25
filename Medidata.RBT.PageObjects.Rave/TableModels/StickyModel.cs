using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// The information necessary when placing a sticky note
    /// </summary>
    public class StickyModel
    {
        /// <summary>
        /// The field the sticky is placed against
        /// </summary>
        public string Field { get; set; }

        /// <summary>
        /// Who must respond to the sticky
        /// </summary>
        public string Responder { get; set; }

        /// <summary>
        /// The text of the sticky
        /// </summary>
        public string Text { get; set; }
    }
}
