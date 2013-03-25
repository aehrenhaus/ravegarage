using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Medidata.RBT.SharedObjects;

namespace Medidata.RBT.Helpers
{
    /// <summary>
    /// Helper class to do math that c# libraries cannot
    /// </summary>
    public static class MathHelper
    {
        /// <summary>
        /// Check that two double precision rectangles overlap with each other
        /// </summary>
        /// <param name="rect1">The first rectangle</param>
        /// <param name="rect2">The second rectangle</param>
        /// <returns>The rectangles overlap</returns>
        public static bool TwoDoubleRectanglesOverlap(DoubleRectangle rect1, DoubleRectangle rect2)
        {
            bool xOverlap = ValuesOverlap(rect1.X, rect2.X, rect2.X + rect2.Width) ||
                    ValuesOverlap(rect2.X, rect1.X, rect1.X + rect1.Width);

            bool yOverlap = ValuesOverlap(rect1.Y, rect2.Y, rect2.Y + rect2.Height) ||
                            ValuesOverlap(rect2.Y, rect1.Y, rect1.Y + rect2.Height);

            bool rectanglesIntersect = xOverlap && yOverlap;
            bool containedWithin = ContainedWithin(rect1, rect2) || ContainedWithin(rect2, rect1);

            return rectanglesIntersect || containedWithin;
        }

        private static bool ValuesOverlap(double value, double min, double max)
        { 
            return (value >= min) && (value <= max); 
        }

        /// <summary>
        /// True if small rectangle is entirely contained within the larger rectangle
        /// </summary>
        /// <param name="largerRectangle">The larger rectangle</param>
        /// <param name="smallerRectangle">The smaller rectangle</param>
        /// <returns>True if small rectangle is entirely contained within the larger rectangle, false otherwise</returns>
        private static bool ContainedWithin(DoubleRectangle largerRectangle, DoubleRectangle smallerRectangle)
        {
            bool lowerLeftCheck = largerRectangle.LowerLeft.X < smallerRectangle.LowerLeft.X && largerRectangle.LowerLeft.Y < smallerRectangle.LowerLeft.Y;
            bool upperLeftCheck = largerRectangle.UpperLeft.X < smallerRectangle.UpperLeft.X && largerRectangle.UpperLeft.Y > smallerRectangle.UpperLeft.Y;

            bool lowerRightCheck = largerRectangle.LowerRight.X > smallerRectangle.LowerRight.X && largerRectangle.LowerRight.Y < smallerRectangle.LowerRight.Y;
            bool upperRightCheck = largerRectangle.UpperRight.X > smallerRectangle.UpperRight.X && largerRectangle.UpperRight.Y > smallerRectangle.UpperRight.Y;

            return lowerLeftCheck && upperLeftCheck && lowerRightCheck && upperRightCheck;
        }
    }
}
