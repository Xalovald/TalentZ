using Newtonsoft.Json;

namespace talentz_api.DataRequests
{
    public class CalendrierData
    {
        [JsonProperty("date")]
        public DateTime Date { get; set; }

        [JsonProperty("evenements")]
        public required string Evenements { get; set; }

        [JsonProperty("acteurs")]
        public required string Acteurs { get; set; }
    }
}
