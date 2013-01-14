using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Objects.Integration.Configuration.Templates
{
    public class StudyTemplates
    {
        public const string STUDY_POST_TEMPLATE = @"{
                                                    {{#config}}
                                                    ""data"": {
                                                        ""name"": ""{{Name}}"",
                                                        ""is_production"": {{IsProd}},
                                                        ""full_description"": ""{{Description}}"",
                                                        ""uuid"": ""{{UUID}}"",
                                                        ""id"": ""IRRELEVANT_CONTENT"",
                                                        ""enrollment_target"": ""155"",
                                                        ""parent"": {
                                                            ""uuid"": ""6bf09b9e-548e-11df-1234-002608fffe99""
                                                        }
                                                    },
                                                    ""timestamp"": ""{{Timestamp}}"",
                                                    ""resource"": ""com:mdsol:study:~~"",
                                                    ""event"": ""POST"",
                                                    ""source_id"": ""93f46ac9-fcd4-4c45-ac9a-7f1553409c00"",
                                                    ""source"": ""http://localhost:3001"",
                                                    ""message_id"": ""{{MessageId}}""
                                                    {{/config}}
                                                }
                                            ";
    }
}
