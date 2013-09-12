using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT
{
    public interface IVerifyDropdownState
    {
        /// <summary>
        /// Check is the specified option is selected from dropdown
        /// </summary>
        /// <param name="optionText"></param>
        /// <param name="dropdown"></param>
        /// <returns></returns>
        bool IsOptionSelected(string optionText, string dropdown);

        /// <summary>
        /// Check if the specified option exist in selection list for the dropdown
        /// </summary>
        /// <param name="optionText"></param>
        /// <param name="dropdown"></param>
        /// <returns></returns>
        bool OptionExist(string optionText, string dropdown);
    }
}
