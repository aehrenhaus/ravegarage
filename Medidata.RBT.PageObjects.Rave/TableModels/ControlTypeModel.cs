using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels
{
    /// <summary>
    /// This model is to verify various controls are enabled/disabled
    /// </summary>
    public class ControlTypeModel
    {
        /// <summary>
        /// Type of control
        /// </summary>
        public string ControlType { get; set; }

        /// <summary>
        /// Name of control
        /// </summary>
        public string Name { get; set; } 
    }
}
