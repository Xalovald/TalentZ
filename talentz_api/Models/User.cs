namespace talentz_api.Models
{
    public class User : SqlModel
    {
        public override int? Id { get; set; }

        public string? LastName { get; set; }

        public string? CompanyName { get; set; }

        public string? FirstName { get; set; }

        public DateTime? DateNaissance { get; set; }

        public string? Telephone { get; set; }

        public string? Email { get; set; }

        public SecteurActivite? SecteurActivite { get; set; }

        public CompanySize? CompanySize { get; set; }

        public string? TypePoste { get; set; }

        public TypeContrat? TypeContrat { get; set; }

        public string? City { get; set; }

        public string? Address { get; set; }

        public string? Siret { get; set; }

        public string? Location { get; set; }

        public string? Role { get; set; }

        public List<Apprentissage>? Apprentissages { get; set; }

        public List<Avantage>? Avantages { get; set; }

        public List<Carriere>? Carrieres { get; set; }

        public List<Competence>? Competences { get; set; }

        public List<Mission>? Missions { get; set; }

        public List<Personnalite>? Personnalites { get; set; }

        public List<ValeurEthique>? ValeursEthiques { get; set; }

        public QuestionMystere? QuestionMystere { get; set; }

        public Cerise? Cerise { get; set; }

        public string? WhyCerise { get; set; }
    }
}
