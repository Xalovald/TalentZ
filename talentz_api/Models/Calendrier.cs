namespace talentz_api.Models
{
    public class Calendrier : SqlModel
    {
        public override int? Id { get; set; }

        public DateTime? Date { get; set; }

        public string? Evenements { get; set; }

        public string? Acteurs { get; set; }
    }
}
