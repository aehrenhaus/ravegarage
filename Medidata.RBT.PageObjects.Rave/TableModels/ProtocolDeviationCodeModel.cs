using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// The information necessary when creating a Protocol Deviation Code
    /// </summary>
    public class ProtocolDeviationCodeModel
    {
        /// <summary>
        /// Protocol Deviation Code value
        /// </summary>
        public string CodeValue { get; set; }

        /// <summary>
        /// Active
        /// </summary>
        public bool Active { set; get; }
    }
}
