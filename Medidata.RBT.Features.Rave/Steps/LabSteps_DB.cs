using System;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using Medidata.RBT.PageObjects.Rave;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow.Assist;
using Medidata.RBT.PageObjects.Rave.SharedRaveObjects;
using System.Linq;

namespace Medidata.RBT.Features.Rave.Steps
{
    [Binding]
    public partial class LabSteps_DB : BrowserStepsBase
    {
        #region LabAnalyteAudit

        private static string GetLabAnalyteRangeAuditSql(AnalyteRangeAuditModel model)//string analyteName, string labName, string objectTypeName, string auditSubCategory)
        {
            string objectTypeName = String.Empty;

            switch (model.ObjectName)
            {
                case "AnalyteRange":
                    objectTypeName = "Medidata.Core.Objects.Labs.AnalyteRange";
                    break;
                default:
                    throw new NotImplementedException(String.Format("Unknown Object UniqueName: {0}", model.ObjectName));
            }    
            return String.Format("declare @Analyte varchar(2000) = '{0}' " +
                                       "declare @LabName varchar(2000)= '{1}' " +
                                       "declare @ObjectTypeName varchar(2000) = '{2}' " +
                                       "declare @AuditSubCategoryName varchar(2000) = '{3}' " +
                                       "declare @Objecttypeid int, @AuditSubCategoryId int " +
                                       "set @objecttypeid = (select objecttypeid from objecttyper where objectname = @ObjectTypeName) " +
                                       "set @AuditSubCategoryId = (select ID from AuditSubCategoryR where name = @AuditSubCategoryName) " +
                                       "select *  " +
                                       "from audits ad " +
                                       "   join analyteranges ar on ar.analyterangeid = ad.objectid and ad.objecttypeid = @Objecttypeid " +
                                       "  join analytes an on an.analyteid = ar.analyteid " +
                                       "  join labs lb on lb.labid = ar.labid " +
                                       "where dbo.fnlocaldefault(lb.labnameid) = @LabName and lb.Active = 1 and ar.Active = 1 and ad.AuditSubCategoryId = @AuditSubCategoryId", model.Analyte, model.Lab, objectTypeName, model.AuditName);
        }


        /// <summary>
        /// Verify that analyterange audit exists.
        /// </summary>
        /// <param name="table">The table.</param>
        [StepDefinition(@"I verify analyterange audits exist")]
        public void IVerifyAnalyterangeAuditsExist__(Table table)
        {
            SpecialStringHelper.ReplaceTableColumn(table, "Lab");
            string sql = GetLabAnalyteRangeAuditSql(table.CreateInstance<AnalyteRangeAuditModel>());
            var dataTable = DbHelper.ExecuteDataSet(sql).Tables[0];
            Assert.IsTrue((int)dataTable.Rows.Count >= 1, "AnalyteRange Audits does not exist");
        }

        #endregion LabAnalyteAudit

       
    }
}
