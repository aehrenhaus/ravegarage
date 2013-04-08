using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;

namespace Medidata.RBT.SharedObjects
{
    /// <summary>
    /// Used to keep track of an element and where it was found in a loop, 
    /// so that it may be refered to be its index in that loop later.
    /// Can save some time instead of iterating through the loop again.
    /// </summary>
    public class ElementWithIndex
    {
        public int Index { get; set; }
        public IWebElement Element { get; set; }
    }
}
