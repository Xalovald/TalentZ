namespace talentz_api.Models
{
    public class QuestionMystere : SqlModel
    {
        public override int? Id { get; set; }
        public string? Text { get; set; }
        public string? Reponse { get; set; }
    }
}
