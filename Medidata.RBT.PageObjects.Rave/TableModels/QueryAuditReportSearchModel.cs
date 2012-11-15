using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
    public class QueryAuditReportSearchModel
    {
        public string Site { get; set; }
        public string SiteGroup { get; set; }
        public string Subject { get; set; }
        public string Folder { set; get; }
        public string Form { set; get; }
        public int? PageRptNumber { get; set; }
        public string Field { set; get; }
        public int? LogNo { get; set; }
        public string AuditAction { get; set; }
        public string AuditUser { get; set; }
        public string AuditRole { get; set; }
        public string AuditActionType { get; set; }
        public string AuditTime { get; set; }
    }
}

