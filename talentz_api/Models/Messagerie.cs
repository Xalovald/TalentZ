namespace talentz_api.Models
{
    public class Messagerie : SqlModel
    {
        public override int? Id { get; set; }

        public int? IdDestinataire { get; set; }

        public int? IdEnvoyeur { get; set; }

        public string? Message { get; set; }

        public DateTime? DateEnvoi { get; set; }
    }
}
