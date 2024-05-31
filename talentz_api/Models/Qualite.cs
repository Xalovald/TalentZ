namespace talentz_api.Models
{
    public class Qualite : SqlModel
    {
        public override int Id { get; set; }
        public required string Nom { get; set; }
    }
}
