using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Selenium;

namespace Medidata.RBT.SeleniumExtension.Exceptions
{
    public class ControlDisabledException : SeleniumException
    {
        public ControlDisabledException(string message) : base(message)
        {
        }
    }
}
