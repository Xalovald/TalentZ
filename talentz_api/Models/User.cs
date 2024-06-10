namespace talentz_api.Models
{
    public class User : SqlModel
    {
        public override int Id { get; set; }

        public string? LastName { get; set; }

        public string? CompanyName { get; set; }

        public string? FirstName { get; set; }

        public DateTime? DateNaissance { get; set; }

        public string? Telephone { get; set; }

        public string? Email { get; set; }

        public string? City { get; set; }

        public string? Address { get; set; }

        public string? Siret { get; set; }

        public string? Location { get; set; }

        public string? Role { get; set; }

        public List<Qualite>? Qualites { get; set; }

        public string? Password { get; set; }

        public int? Cerise { get; set; }

        public string? WhyCerise { get; set; }
    }
}
