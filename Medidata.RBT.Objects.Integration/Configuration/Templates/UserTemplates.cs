
namespace Medidata.RBT.Objects.Integration.Configuration.Templates
{
    public static class UserTemplates
    {
        public const string USER_PUT_TEMPLATE = "{\r\n" +
                                                    "{{#config}}\r\n" +
                                                    "\"data\": {\r\n" +
                                                        "\"email\": \"{{Email}}\",\r\n" +
                                                        "\"login\": \"{{Login}}\",\r\n" +
                                                        "\"uuid\": \"{{UUID}}\",\r\n" +
                                                        "\"id\": {{ID}},\r\n" +
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
                                                        "\"institution\": \"{{Institution}}\"\r\n" +
                                                    "},\r\n" +
                                                    "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                    "\"resource\": \"com:mdsol:user:~~\",\r\n" +
                                                    "\"event\": \"PUT\",\r\n" +
                                                    "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                    "\"source\": \"http://localhost:3001\",\r\n" +
                                                    "\"message_id\": \"{{MessageId}}\"\r\n" +
                                                    "{{/config}}\r\n" +
                                                "}";
    }
}