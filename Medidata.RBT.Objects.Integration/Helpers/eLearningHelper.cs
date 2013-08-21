using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Medidata.Core.Common.Utilities;
using Medidata.Core.Objects;
using Medidata.Data;
using Medidata.Data.Configuration;

namespace Medidata.RBT.Objects.Integration.Helpers
{
    public static class eLearningHelper
    {
        public static void SaveCourseFile(int courseId, byte[] eLearningCourseFile)
        {
            var dbCon = Agent.GetOpenConnection(Connection.ConnectionHint);
            Agent.ExecuteNonQuery(dbCon, null, "speLearningCourseFileUpsert",
                                  new object[] {courseId, eLearningCourseFile, "eng", true});
            Agent.SafeShut(dbCon);
        }
    }
}