using Newtonsoft.Json;

namespace talentz_api.DataRequests
{
    public class LoginData
    {
        [JsonProperty("email")]
        public required string Email { get; set; }

        [JsonProperty("password")]
        public required string Password { get; set; }
    }
}
