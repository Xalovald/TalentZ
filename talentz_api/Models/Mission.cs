namespace talentz_api.Models
{
    public class Mission : SqlModel
    {
        public override int? Id { get; set; }
        public string? Text { get; set; }
    }
}
