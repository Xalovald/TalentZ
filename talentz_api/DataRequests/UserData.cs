using Newtonsoft.Json;

namespace talentz_api.JsonData
{
    public class UserCandidatData
    {
        [JsonProperty("lastName")]
        public required string LastName { get; set; }

        [JsonProperty("firstName")]
        public required string FirstName { get; set; }

        [JsonProperty("telephone")]
        public required string Telephone { get; set; }

        [JsonProperty("dateNaissance")]
        public required DateTime DateNaissance { get; set; }

        [JsonProperty("email")]
        public required string Email { get; set; }

        [JsonProperty("ville")]
        public required string City { get; set; }

        [JsonProperty("adresse")]
        public required string Address { get; set; }

        [JsonProperty("password")]
        public required string Password { get; set; }

        [JsonProperty("cerise")]
        public required string Cerise { get; set; }

        [JsonProperty("whyCerise")]
        public required string WhyCerise { get; set; }

        [JsonProperty("qualites")]
        public required List<string> Qualites {  get; set; }
    }

    public class UserEntrepriseData
    {
        [JsonProperty("companyName")]
        public required string CompanyName { get; set; }

        [JsonProperty("telephone")]
        public required string Telephone { get; set; }

        [JsonProperty("email")]
        public required string Email { get; set; }

        [JsonProperty("location")]
        public required string Location { get; set; }

        [JsonProperty("siret")]
        public required string Siret { get; set; }

        [JsonProperty("password")]
        public required string Password { get; set; }

        [JsonProperty("qualites")]
        public required List<string> Qualites { get; set; }
    }
}
