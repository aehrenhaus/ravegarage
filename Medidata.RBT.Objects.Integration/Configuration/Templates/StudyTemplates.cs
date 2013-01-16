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
                                                        "\"enrollment_target\": \"\",\r\n" +
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

        public const string STUDY_PUT_TEMPLATE = "{\r\n" +
                                                    "{{#config}}\r\n" +
                                                    "\"version\": \"2012.2.0\",\r\n" +
                                                    "\"message_id\": \"{{MessageId}}\",\r\n" +
                                                    "\"event\": \"PUT\",\r\n" +
                                                    "\"source\": \"http://localhost:3001\",\r\n" +
                                                    "\"source_id\": \"42c84c68-9937-11e1-86f0-12313d194429\",\r\n" +
                                                    "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                    "\"resource\": \"com:mdsol:study:~~\",\r\n" +
                                                    "\"data\": {\r\n" +
                                                        "\"type\": null,\r\n" +
                                                        "\"uuid\": \"{{UUID}}\",\r\n" +
                                                        "\"id\": \"{{ID}}\",\r\n" +
                                                        "\"parent\": {\r\n" +
                                                            "\"type\": \"StudyGroup\",\r\n" +
                                                            "\"uuid\": \"2de2dee6-7838-11e1-aa64-123138140309\"\r\n" +
                                                        "},\r\n" +
                                                        "\"name\": \"{{Name}}\",\r\n" +
                                                        "\"updated_at\": \"2012-08-01T09:40:06-04:00\",\r\n" +
                                                        "\"enrollment_target\": \"\",\r\n" +
                                                        "\"full_description\": \"{{Description}}\",\r\n" +
                                                        "\"is_production\": {{IsProd}}\r\n" +
                                                    "}\r\n" +
                                                    "{{/config}}\r\n" +
                                                "}";
    }
}
