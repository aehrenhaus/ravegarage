namespace Medidata.RBT.Objects.Integration.Configuration.Templates
{
    public static class StudyTemplates
    {
        public const string STUDY_POST_TEMPLATE = "{\r\n" +
                                                    "{{#config}}\r\n" +
                                                    "\"data\": {\r\n" +
                                                        "\"name\": \"{{Name}}\",\r\n" +
                                                        "\"is_production\": {{IsProd}},\r\n" +
                                                        "\"full_description\": \"{{Description}}\",\r\n" +
                                                        "\"uuid\": \"{{UUID}}\",\r\n" +
                                                        "\"id\": \"{{ID}}\",\r\n" +
                                                        "\"enrollment_target\": \"155\",\r\n" +
                                                        "\"parent\": {\r\n" +
                                                            "\"uuid\": \"6bf09b9e-548e-11df-1234-002608fffe99\"\r\n" +
                                                        "}\r\n" +
                                                    "},\r\n" +
                                                    "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                    "\"resource\": \"com:mdsol:study:~~\",\r\n" +
                                                    "\"event\": \"POST\",\r\n" +
                                                    "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                    "\"source\": \"http://localhost:3001\",\r\n" +
                                                    "\"message_id\": \"{{MessageId}}\"\r\n" +
                                                    "{{/config}}\r\n" +
                                                "}";
    }
}
