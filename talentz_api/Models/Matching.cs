namespace talentz_api.Models
{
    public class Matching : SqlModel
    {
        public override int? Id { get; set; }
        public User User { get; set; }
        public double Score { get; set; }
    }
}