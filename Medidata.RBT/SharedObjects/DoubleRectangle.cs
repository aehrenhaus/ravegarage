using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.SharedObjects
{
    public class DoubleRectangle
    {
        public DoubleRectangle(double x, double y, double width, double height)
        {
            X = x;
            Y = y;
            Width = width;
            Height = height;
        }

        //The lower left most x coordinate
        public double X { get; set; }
        //The lower left most y coordinate
        public double Y { get; set; }
        public double Width { get; set; }
        public double Height { get; set; }
    }
}
