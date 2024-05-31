using Newtonsoft.Json;

namespace talentz_api.DataRequests
{
    public class MatchingData
    {
        [JsonProperty("idEntreprise")]
        public int IdEntreprise { get; set; }

        [JsonProperty("idCandidat")]
        public int IdCandidat { get; set; }

        [JsonProperty("date")]
        public DateTime Date { get; set; }
    }
}
