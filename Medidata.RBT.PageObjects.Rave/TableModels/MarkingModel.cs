using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// The information necessary when placing a sticky note
    /// </summary>
    public class MarkingModel
    {
        /// <summary>
        /// The field the sticky is placed against
        /// </summary>
        public string Field { get; set; }

        /// <summary>
        /// Who must respond to the marking
        /// </summary>
        public string Responder { get; set; }

        /// <summary>
        /// The text of the marking
        /// </summary>
        public string Text { get; set; }

        /// <summary>
        /// Protocol Deviation Code value
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// Protocol Deviation Class value
        /// </summary>
        public string Class { set; get; }

        /// <summary>
        /// Log line number (in log and mixed forms)
        /// </summary>
        public int? Record { set; get; }
    }

    public enum MarkingType
    {
        Sticky,
        Query,
        ProtocolDeviation,
        Comment
    }
}
