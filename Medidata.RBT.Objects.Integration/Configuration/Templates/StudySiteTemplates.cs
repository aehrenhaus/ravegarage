
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Objects.Integration.Configuration.Templates
{
    public static class StudySiteTemplates
    {
        public const string POST_TEMPLATE = "{\r\n"+
                                                "{{#config}}\r\n" +
                                                "\"event\": \"POST\",\r\n" +
                                                "\"resource\": \"com:mdsol:study_site:~~\",\r\n" +
                                                "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                "\"source\": \"http://localhost:3001\",\r\n" +
                                                "\"message_id\": \"{{MessageId}}\",\r\n" +
                                                "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                "\"data\": {\r\n" +
                                                    "\"type\": \"StudySite\",\r\n" +
                                                    "\"uuid\": \"{{StudySiteUuid}}\",\r\n" +
                                                    "\"id\": {{StudySiteId}},\r\n" +
                                                    "\"number\": \"{{StudySiteNumber}}\",\r\n" +
                                                    "\"name\": \"{{StudySiteName}}\",\r\n" +
                                                    "\"study\": {\r\n" +
                                                        "\"type\": \"Study\",\r\n" +
                                                        "\"uuid\": \"{{StudyUuid}}\",\r\n" +
                                                        "\"id\": {{StudyId}}\r\n" +
                                                    "},\r\n" +
                                                    "\"site\": {\r\n" +
                                                        "\"type\": \"Site\",\r\n" +
                                                        "\"uuid\": \"{{SiteUuid}}\",\r\n" +
                                                        "\"id\": {{SiteId}},\r\n" +
                                                        "\"name\": \"{{SiteName}}\",\r\n" +
                                                        "\"number\": \"{{SiteNumber}}\"\r\n" +
                                                    "}\r\n" +
                                                "}\r\n" +
                                                "{{/config}}\r\n" +
                                            "}\r\n";
    }
}
