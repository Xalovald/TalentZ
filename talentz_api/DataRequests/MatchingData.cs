using Newtonsoft.Json;

namespace talentz_api.JsonData
{
    public class MatchingData
    {
        [JsonProperty("idUser")]
        public int IdUser { get; set; }
    }
}