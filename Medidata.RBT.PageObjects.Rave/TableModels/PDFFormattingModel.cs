using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    public class PDFFormattingModel
    {
        public string Font { get; set; }
        public int FontSize { get; set; }
        public double TopMargin { get; set; }
        public double BottomMargin { get; set; }
        public double LeftMargin { get; set; }
        public double RightMargin { get; set; }
        public string PageNumber { get; set; }
    }
}
