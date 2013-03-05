using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using O2S.Components.PDF4NET.Text;

namespace Medidata.RBT.PageObjects.Rave.SharedRaveObjects
{
    /// <summary>
    /// The audit model used for PDF audits
    /// </summary>
    public class PDFAudit
    {
        public PDFTextRun Time { get; set; }
        public BaseEnhancedPDFSearchTextResult User { get; set; }
        public PDFTextRun Message { get; set; }
    }
}
