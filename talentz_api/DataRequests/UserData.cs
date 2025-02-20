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

        [JsonProperty("typeContrat")]
        public required int TypeContrat { get; set; }

        [JsonProperty("ville")]
        public required string City { get; set; }

        [JsonProperty("adresse")]
        public required string Address { get; set; }

        [JsonProperty("password")]
        public required string Password { get; set; }

        [JsonProperty("cerise")]
        public required string? Cerise { get; set; }

        [JsonProperty("whyCerise")]
        public required string WhyCerise { get; set; }

        [JsonProperty("apprentissages")]
        public required List<int?> Apprentissages {  get; set; }

        [JsonProperty("avantages")]
        public required List<int?> Avantages { get; set; }

        [JsonProperty("carrieres")]
        public required List<int?> Carrieres { get; set; }

        [JsonProperty("competences")]
        public required List<int?> Competences { get; set; }

        [JsonProperty("missions")]
        public required List<int?> Missions { get; set; }

        [JsonProperty("personnalites")]
        public required List<int?> Personnalites { get; set; }

        [JsonProperty("valeursEthiques")]
        public required List<int?> ValeursEthiques { get; set; }

        [JsonProperty("questionMystereId")]
        public Dictionary<string, dynamic>? QuestionMystere { get; set; }
    }

    public class UserEntrepriseData
    {
        [JsonProperty("companyName")]
        public required string CompanyName { get; set; }

        [JsonProperty("telephone")]
        public required string Telephone { get; set; }

        [JsonProperty("email")]
        public required string Email { get; set; }

        [JsonProperty("secteurActivite")]
        public required int SecteurActivite { get; set; }

        [JsonProperty("companySize")]
        public required int CompanySize { get; set; }

        [JsonProperty("typePoste")]
        public required string TypePoste { get; set; }

        [JsonProperty("typeContrat")]
        public required int TypeContrat { get; set; }

        [JsonProperty("location")]
        public required string Location { get; set; }

        [JsonProperty("siret")]
        public required string Siret { get; set; }

        [JsonProperty("password")]
        public required string Password { get; set; }

        [JsonProperty("cerise")]
        public required string? Cerise { get; set; }

        [JsonProperty("whyCerise")]
        public required string WhyCerise { get; set; }

        [JsonProperty("apprentissages")]
        public required List<int?> Apprentissages { get; set; }

        [JsonProperty("avantages")]
        public required List<int?> Avantages { get; set; }

        [JsonProperty("carrieres")]
        public required List<int?> Carrieres { get; set; }

        [JsonProperty("competences")]
        public required List<int?> Competences { get; set; }

        [JsonProperty("missions")]
        public required List<int?> Missions { get; set; }

        [JsonProperty("personnalites")]
        public required List<int?> Personnalites { get; set; }

        [JsonProperty("valeursEthiques")]
        public required List<int?> ValeursEthiques { get; set; }
    }
}
