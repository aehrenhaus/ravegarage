using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;

namespace Medidata.RBT.SharedObjects
{
    /// <summary>
    /// Double precision rectangle
    /// </summary>
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

        public Point UL
        {
            get
            {
                return new Point(X, Y + Height);
            }
        }

        public Point LL
        {
            get
            {
                return new Point(X, Y);
            }
        }

        public Point UR
        {
            get
            {
                return new Point(X + Width, Y + Height);
            }
        }

        public Point LR
        {
            get
            {
                return new Point(X + Width, Y);
            }
        }
    }
}
