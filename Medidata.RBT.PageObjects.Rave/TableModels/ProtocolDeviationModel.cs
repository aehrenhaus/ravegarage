using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// The information necessary when creating a Protocol Deviation
    /// </summary>
    public class ProtocolDeviationModel
    {
        /// <summary>
        /// The field the Protocol Deviation is created on
        /// </summary>
        public string Field { get; set; }

        /// <summary>
        /// Protocol Deviation Class value
        /// </summary>
        public string Class { get; set; }

        /// <summary>
        /// Protocol Deviation Code value
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// The text of the Protocol Deviation
        /// </summary>
        public string Text { get; set; }

        /// <summary>
        /// Log line number (in log and mixed forms)
        /// </summary>
        public int? Record { set; get; }
    }
}
