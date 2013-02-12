
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.Objects.Integration.Configuration.Templates
{
    public static class SiteTemplates
    {
        public const string POST_TEMPLATE = "{\r\n"+
                                                "{{#config}}\r\n" +
                                                "\"event\": \"POST\",\r\n" +
                                                "\"resource\": \"com:mdsol:site:~~\",\r\n" +
                                                "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                "\"source\": \"http://localhost:3001\",\r\n" +
                                                "\"message_id\": \"{{MessageId}}\",\r\n" +
                                                "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                "\"data\": {\r\n" +
                                                            "\"id\": {{Id}},\r\n" +
                                                            "\"name\": \"{{Name}}\",\r\n" +
                                                            "\"number\": \"{{Number}}\",\r\n" +
                                                            "\"city\": \"{{City}}\",\r\n" +
                                                            "\"country\": \"{{Country}}\",\r\n" +                                                          
                                                            "\"uuid\": \"{{Uuid}}\",\r\n" +
                                                            "\"updated_at\": \"{{UpdatedAt}}\",\r\n" +
                                                            "\"postal_code\": \"{{PostalCode}}\",\r\n" +
                                                            "\"type\": \"Site\",\r\n" +
                                                            "\"address_line_1\": \"{{Address1}}\",\r\n" +
                                                            "\"address_line_2\": \"{{Address2}}\",\r\n" +
                                                            "\"phone\": \"{{Phone}}\",\r\n" +
                                                            "\"fax\": \"{{Fax}}\",\r\n" +
                                                            "\"address_line_3\": \"{{Address3}}\",\r\n" +
                                                            "\"state\": \"{{State}}\"\r\n" +                                            
                                                "}\r\n" +
                                                "{{/config}}\r\n" +
                                            "}\r\n";

        public const string PUT_TEMPLATE = "{\r\n" +
                                                "{{#config}}\r\n" +
                                                "\"event\": \"PUT\",\r\n" +
                                                "\"resource\": \"com:mdsol:site:~~\",\r\n" +
                                                "\"source_id\": \"93f46ac9-fcd4-4c45-ac9a-7f1553409c00\",\r\n" +
                                                "\"source\": \"http://localhost:3001\",\r\n" +
                                                "\"message_id\": \"{{MessageId}}\",\r\n" +
                                                "\"timestamp\": \"{{Timestamp}}\",\r\n" +
                                                "\"data\": {\r\n" +
                                                            "\"id\": {{Id}},\r\n" +
                                                            "\"name\": \"{{Name}}\",\r\n" +
                                                            "\"number\": \"{{Number}}\",\r\n" +
                                                            "\"city\": \"{{City}}\",\r\n" +
                                                            "\"country\": \"{{Country}}\",\r\n" +
                                                            "\"uuid\": \"{{Uuid}}\",\r\n" +
                                                            "\"updated_at\": \"{{UpdatedAt}}\",\r\n" +
                                                            "\"postal_code\": \"{{PostalCode}}\",\r\n" +
                                                            "\"type\": \"Site\",\r\n" +
                                                            "\"address_line_1\": \"{{Address1}}\",\r\n" +
                                                            "\"address_line_2\": \"{{Address2}}\",\r\n" +
                                                            "\"phone\": \"{{Phone}}\",\r\n" +
                                                            "\"fax\": \"{{Fax}}\",\r\n" +
                                                            "\"address_line_3\": \"{{Address3}}\",\r\n" +
                                                            "\"state\": \"{{State}}\"\r\n" +
                                                "}\r\n" +
                                                "{{/config}}\r\n" +
                                            "}\r\n";
    }
}
