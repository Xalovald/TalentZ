using Newtonsoft.Json;

namespace talentz_api.DataRequests
{
    public class ContactData
    {
        [JsonProperty("date")]
        public DateTime Date { get; set; }

        [JsonProperty("mail")]
        public required string Mail { get; set; }

        [JsonProperty("message")]
        public required string Message { get; set; }

        [JsonProperty("objet")]
        public required string Objet { get; set; }
    }
}
