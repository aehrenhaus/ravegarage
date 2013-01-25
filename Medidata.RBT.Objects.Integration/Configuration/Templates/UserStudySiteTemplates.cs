
namespace Medidata.RBT.Objects.Integration.Configuration.Templates
{
    public static class UserStudySiteTemplates
    {
        public const string USERSTUDYSITE_POST_TEMPLATE =   "{\r\n" +
                                                                "{{#config}}\r\n" +
                                                                "\"data\": {\r\n" +
                                                                    "\"uuid\": \"{{UUID}}\",\r\n" +
                                                                    "\"enabled\": true,\r\n" +
                                                                    "\"updated_at\": \"{{UpdatedAt}}\",\r\n" +
                                                                    "\"type\": \"StudySiteAssignment\", \r\n" +
                                                                    "\"user\": {\r\n" +
                                                                          "\"id\": \"{{ID}}\",\r\n" +
                                                                          "\"uuid\": \"{{UserUUID}}\",\r\n" +
                                                                          "\"type\": \"User\"\r\n" +
                                                                    "},\r\n" +
                                                                    "\"study_site\": {\r\n" +
                                                                          "\"id\": \"{{StudySiteID}}\",\r\n" +
                                                                          "\"uuid\": \"{{StudySiteUUID}}\"\r\n" +
                                                                    "}\r\n" +
                                                                "},\r\n" +
                                                                "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                                "\"resource\": \"com:mdsol:study_site_assignment:~~\",\r\n" +
                                                                "\"event\": \"POST\",\r\n" +
                                                                "\"source\": \"http://localhost:3001\",\r\n" +
                                                                "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                                "\"message_id\": \"{{MessageId}}\"\r\n" +
                                                                "{{/config}}\r\n" +
                                                             "}";

        public const string USERSTUDYSITE_DELETE_TEMPLATE = "{\r\n" +
                                                                "{{#config}}\r\n" +
                                                                "\"event\": \"DELETE\",\r\n" +
                                                                "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                                "\"resource\": \"com:mdsol:study_site_assignment:~~\",\r\n" +
                                                                "\"data\": {\r\n" +
                                                                    "\"type\": \"StudySiteAssignment\",\r\n" +
                                                                    "\"uuid\": \"{{UUID}}\",\r\n" +
                                                                    "\"study_site\": {\r\n" +
                                                                        "\"study\": {\"uuid\": \"{{StudyUUID}}\"},\r\n" +
                                                                        "\"site\": {\"uuid\": \"{{SiteUUID}}\"},\r\n" +
                                                                        "\"uuid\": \"{{StudySiteUUID}}\"\r\n" +
                                                                    "},\r\n" +
                                                                    "\"user\": {\r\n" +
                                                                        "uuid\": \"{{UserUUID}}\"\r\n" +
                                                                "}\r\n" +
                                                                "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                                "\"resource\": \"com:mdsol:study_site_assignment:~~\",\r\n" +
                                                                "\"event\": \"DELETE\",\r\n" +
                                                                "\"source\": \"http://localhost:3001\",\r\n" +
                                                                "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                                "\"message_id\": \"{{MessageId}}\"\r\n" +
                                                                "{{/config}}\r\n" +
                                                            "}";
    }
}
