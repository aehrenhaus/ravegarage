namespace Medidata.RBT.Objects.Integration.Configuration.Templates
{
    public static class StudyInvitationTemplates
    {
        public const string POST_PUT_TEMPLATE = "{\r\n" +
                                                    "{{#config}}\r\n" +
                                                    "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                    "\"resource\": \"com:mdsol:study_invitation:~~\",\r\n" +
                                                    "\"event\": \"{{EventType}}\",\r\n" +
                                                    "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                    "\"source\": \"http://localhost:3001\",\r\n" +
                                                    "\"message_id\": \"{{MessageId}}\",\r\n" +
                                                    "\"data\": {\r\n" +
                                                        "\"type\": \"{{InvitationType}}\",\r\n" +
                                                        "\"uuid\": \"a3cb01ca-4672-4353-b38f-86d7c312e0a3\",\r\n" +
                                                        "\"inviter\": {\r\n" +
                                                            "\"type\": \"User\",\r\n" +
                                                            "\"uuid\": \"C4F0D938-FE17-4098-AA4F-3490F97D4CA\" \r\n" +
                                                        "},\r\n" +
                                                        "\"inviter_type\": \"User\",\r\n" +
                                                        "\"invitee\": { \r\n" +
                                                            "\"type\": \"User\",\r\n" +
                                                            "\"email\": \"{{Email}}\",\r\n" +
			                                                "\"login\": \"{{Login}}\",\r\n" +
			                                                "\"uuid\": \"{{UserUuid}}\",\r\n" +
			                                                "\"id\": {{UserId}},\r\n" +
			                                                "\"first_name\": \"{{FirstName}}\",\r\n" +
			                                                "\"middle_name\": \"{{MiddleName}}\",\r\n" +
			                                                "\"last_name\": \"{{LastName}}\",\r\n" +
			                                                "\"address_line_1\": \"{{Address1}}\",\r\n" +
			                                                "\"address_line_2\": \"{{Address2}}\",\r\n" +
			                                                "\"address_line_3\": \"{{Address3}}\",\r\n" +
			                                                "\"city\": \"{{City}}\",\r\n" +
			                                                "\"state\": \"{{State}}\",\r\n" +
			                                                "\"postal_code\": \"{{PostalCode}}\",\r\n" +
			                                                "\"country\": \"{{Country}}\",\r\n" +
			                                                "\"telephone\": \"{{Telephone}}\",\r\n" +
			                                                "\"mobile\": \"{{Mobile}}\",\r\n" +
			                                                "\"pager\": \"{{Pager}}\",\r\n" +
			                                                "\"fax\": \"{{Fax}}\",\r\n" +
			                                                "\"locale\": \"{{Locale}}\",\r\n" +
			                                                "\"time_zone\": \"{{TimeZone}}\",\r\n" +
			                                                "\"title\": \"{{Title}}\",\r\n" +
			                                                "\"department\": \"{{Department}}\",\r\n" +
			                                                "\"institution\": \"{{Institution}}\" \r\n" +
                                                        "},\r\n" +
                                                        "\"app_assignments\": [\r\n" +
		                                                    "{{#AppAssignments}}\r\n"+
                                                            "{ \"type\": \"AppAssignment\", \r\n" +
                                                              "\"uuid\": \"e5b64d03-0e63-4517-9c46-11fb49678b8a\", \r\n" +
                                                              "\"app\": { \r\n" +
                                                                  "\"type\": \"App\", \r\n" +
                                                                  "\"uuid\": \"5a2ba558-d25d-47d6-aa61-67fe5b1f62b4\" \r\n" +
                                                                "},  \r\n" +
                                                              "\"study\": { \r\n" +
                                                                  "\"type\": \"Study\", \r\n" +
                                                                  "\"uuid\": \"19278198-d6be-4e12-bf69-6815e608de12\" \r\n" +
                                                                "}, \r\n" +
                                                              "\"roles\": [ \r\n" +
				                                                   "{{#RoleOids}} \r\n" +
                                                                   "{ \r\n" +
                                                                      "\"type\": \"Role\", \r\n" +
                                                                      "\"uuid\": \"2f591a5f-a6d4-4ccb-b789-410e4ee18b57\", \r\n" +
                                                                      "\"oid\": \"{{Oid}}\", \r\n" +
                                                                      "\"name\": \"CRA\" \r\n" +
                                                                   "}, \r\n" +
				                                                   "{{/RoleOids}} \r\n" +
                                                                   "{} \r\n" +
                                                               "], \r\n" +
                                                              "\"updated_at\": \"2012-11-19T12: 55: 28-05: 00\" \r\n" +
                                                           "}, \r\n" +
		                                                   "{{/AppAssignments}} \r\n" +
                                                           "{} \r\n" +
                                                        "], \r\n" +
                                                        "\"accepted_at\": \"2012-11-19T12:57:04-05:00\",\r\n" +
                                                        "\"study\": {\r\n" +
                                                            "\"type\": null,\r\n" +
                                                            "\"uuid\": \"{{StudyUuid}}\"\r\n" +
                                                        "},\r\n" +
                                                            "\"updated_at\": \"2013-01-19T12:57:04-05:00\"\r\n" +
                                                    "}\r\n" +
                                                    "{{/config}}\r\n" +
                                                "}";


        public const string DELETE_TEMPLATE = "{\r\n" +
                                                "{{#config}}\r\n" +
                                                "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                "\"resource\": \"com:mdsol:study_invitation:~~\",\r\n" +
                                                "\"event\": \"{{EventType}}\",\r\n" +
                                                "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                "\"source\": \"http://localhost:3001\",\r\n" +
                                                "\"message_id\": \"{{MessageId}}\",\r\n" +
                                                "\"data\": {\r\n" +
                                                    "\"type\": \"{{InvitationType}}\",\r\n" +
                                                    "\"uuid\": \"a3cb01ca-4672-4353-b38f-86d7c312e0a3\",\r\n" +
                                                    "\"inviter\": {\r\n" +
                                                        "\"type\": \"User\",\r\n" +
                                                        "\"uuid\": \"C4F0D938-FE17-4098-AA4F-3490F97D4CA\" \r\n" +
                                                    "},\r\n" +
                                                    "\"invitee\": { \r\n" +
                                                        "\"uuid\": \"{{UserUuid}}\",\r\n" +
                                                        "\"id\": {{UserId}},\r\n" +
                                                    "},\r\n" +
                                                    "\"app_assignments\": [ ], \r\n" +
                                                    "\"study\": {\r\n" +
                                                        "\"type\": null,\r\n" +
                                                        "\"uuid\": \"{{StudyUuid}}\"\r\n" +
                                                    "},\r\n" +
                                                        "\"updated_at\": \"2013-01-19T12:57:04-05:00\"\r\n" +
                                                "}\r\n" +
                                                "{{/config}}\r\n" +
                                            "}";
    }
}
