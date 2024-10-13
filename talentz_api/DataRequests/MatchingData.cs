using Newtonsoft.Json;

namespace talentz_api.DataRequests
{
    public class MatchingData
    {
        [JsonProperty("idUser")]
        public int IdUser { get; set; }
    }
}
