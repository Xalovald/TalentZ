using Newtonsoft.Json;

namespace talentz_api.DataRequests
{
    public class MessagerieData
    {
        [JsonProperty("idDestinaire")]
        public int IdDestinataire { get; set; }

        [JsonProperty("idEnvoyeur")]
        public int IdEnvoyeur { get; set; }

        [JsonProperty("message")]
        public required string Message { get; set; }

        [JsonProperty("dateEnvoi")]
        public DateTime DateEnvoi { get; set; }
    }
}
