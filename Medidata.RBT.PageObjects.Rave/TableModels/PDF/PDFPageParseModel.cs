using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave.TableModels.PDF
{
    public class PDFPageParseModel
    {
        public string Font { get; set; }
        public int? FontSize { get; set; }
        public double? TopMargin { get; set; }
        public double? BottomMargin { get; set; }
        public double? LeftMargin { get; set; }
        public double? RightMargin { get; set; }
        public string PageNumber { get; set; }
        public string GeneratedOn { get; set; }
        public string Folder { get; set; }
        public string CRFVersion { get; set; }
    }
}
