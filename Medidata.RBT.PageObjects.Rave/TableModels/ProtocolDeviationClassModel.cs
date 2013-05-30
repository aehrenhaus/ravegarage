using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// The information necessary when creating a Protocol Deviation Class
    /// </summary>
    public class ProtocolDeviationClassModel
    {
        /// <summary>
        /// Protocol Deviation Class value
        /// </summary>
        public string ClassValue { get; set; }

        /// <summary>
        /// Active
        /// </summary>
        public bool Active { set; get; }
    }
}
