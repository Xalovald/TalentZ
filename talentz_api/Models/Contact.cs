namespace talentz_api.Models
{
    public class Contact : SqlModel
    {
        public override int? Id { get; set; }

        public DateTime? Date { get; set; }

        public string? Mail { get; set; }

        public string? Objet { get; set; }

        public string? Message { get; set; }
    }
}
