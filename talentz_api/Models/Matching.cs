namespace talentz_api.Models
{
    public class Matching : SqlModel
    {
        public override int? Id { get; set; }
        public int? IdEntreprise { get; set; }
        public List<Apprentissage>? CommonQualites { get; set; }
        public int? Score { get; set; }
        public int? IdCandidat { get; set; }
    }
}
