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

        public Point UpperLeft
        {
            get
            {
                return new Point(X, Y + Height);
            }
        }

        public Point LowerLeft
        {
            get
            {
                return new Point(X, Y);
            }
        }

        public Point UpperRight
        {
            get
            {
                return new Point(X + Width, Y + Height);
            }
        }

        public Point LowerRight
        {
            get
            {
                return new Point(X + Width, Y);
            }
        }
    }
}
