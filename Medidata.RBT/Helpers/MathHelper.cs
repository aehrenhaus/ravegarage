using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.Helpers
{
    public static class MathHelper
    {
        public static bool TwoDoubleRectanglesIntersect(DoubleRectangle rect1, DoubleRectangle rect2)
        {
            bool xOverlap = ValuesOverlap(rect1.X, rect2.X, rect2.X + rect2.Width) ||
                    ValuesOverlap(rect2.X, rect1.X, rect1.X + rect1.Width);

            bool yOverlap = ValuesOverlap(rect1.Y, rect2.Y, rect2.Y + rect2.Height) ||
                            ValuesOverlap(rect2.Y, rect1.Y, rect1.Y + rect2.Height);

            return xOverlap && yOverlap;
        }

        private static bool ValuesOverlap(double value, double min, double max)
        { 
            return (value >= min) && (value <= max); 
        }
    }
}
