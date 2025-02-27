using Microsoft.AspNetCore.Mvc;
using Mysqlx.Expr;
using System.Data;
using talentz_api.Accessing;
using talentz_api.JsonData;
using talentz_api.Helpers;
using talentz_api.Models;
using talentz_api.Sql;
using talentz_api.Sql.Statements;
using static talentz_api.Helpers.HelperMethods;

namespace talentz_api.Controllers
{
    [ApiController]
    [Produces("application/json")]
    [Consumes("application/json")]
    [Route("/api/matching")]
    public class MatchingController : UserControllerBase
    {
        [HttpGet]
        public List<Matching> MatchCandidatWithEnterprises([FromBody] MatchingData matchingData)
        {
            var results = new List<Matching>();

            SqlQuery sqlQueryUsers = CustomQueries.QueryOneUser(matchingData.IdUser, conn);

            DataRow row = sqlQueryUsers.GetTable().Rows[0];

            List<Apprentissage> dataApprentissages = GetTableFromInvIdx<Apprentissage>(row, "invidx_apprentissages", "apprentissages");
            List<Avantage> dataAvantages = GetTableFromInvIdx<Avantage>(row, "invidx_avantages", "avantages");
            List<Carriere> dataCarrieres = GetTableFromInvIdx<Carriere>(row, "invidx_carrieres", "carrieres");
            List<Competence> dataCompetences = GetTableFromInvIdx<Competence>(row, "invidx_competences", "competences");
            List<Personnalite> dataPersonnalites = GetTableFromInvIdx<Personnalite>(row, "invidx_personnalites", "personnalites");
            List<ValeurEthique> dataValeursEthiques = GetTableFromInvIdx<ValeurEthique>(row, "invidx_valeurs_ethiques", "valeurs_ethiques");

            if ((string)row["role"] == "candidat")
            {
                var entreprises = CustomQueries.QueryRoleUser("entreprise", conn);

                foreach (DataRow row_entreprise in entreprises.GetTable().Rows)
                {
                    List<Apprentissage> dataApprentissagesEntreprise = GetTableFromInvIdx<Apprentissage>(row_entreprise, "invidx_apprentissages", "apprentissages");
                    List<Avantage> dataAvantagesEntreprise = GetTableFromInvIdx<Avantage>(row_entreprise, "invidx_avantages", "avantages");
                    List<Carriere> dataCarrieresEntreprise = GetTableFromInvIdx<Carriere>(row_entreprise, "invidx_carrieres", "carrieres");
                    List<Competence> dataCompetencesEntreprise = GetTableFromInvIdx<Competence>(row_entreprise, "invidx_competences", "competences");
                    List<Personnalite> dataPersonnalitesEntreprise = GetTableFromInvIdx<Personnalite>(row_entreprise, "invidx_personnalites", "personnalites");
                    List<ValeurEthique> dataValeursEthiquesEntreprise = GetTableFromInvIdx<ValeurEthique>(row_entreprise, "invidx_valeurs_ethiques", "valeurs_ethiques");
                    // Find common qualities
                    List<double> scores = [
                        FindCommonAsPercentage(dataApprentissages, dataApprentissagesEntreprise, new IdComparer<Apprentissage>()),
                        FindCommonAsPercentage(dataAvantages, dataAvantagesEntreprise, new IdComparer<Avantage>()),
                        FindCommonAsPercentage(dataCarrieres, dataCarrieresEntreprise, new IdComparer<Carriere>()),
                        FindCommonAsPercentage(dataCompetences, dataCompetencesEntreprise, new IdComparer<Competence>()),
                        FindCommonAsPercentage(dataPersonnalites, dataPersonnalitesEntreprise, new IdComparer<Personnalite>()),
                        FindCommonAsPercentage(dataValeursEthiques, dataValeursEthiquesEntreprise, new IdComparer<ValeurEthique>()),
                        row["types_contrat"].Equals(row_entreprise["types_contrat"]) ? 100 : 0
                    ];
                    double score;
                    score = scores.Sum() / scores.Count;
                    // Add the result to the list
                    if (score > 0)
                    {
                        results.Add(new Matching
                        {
                            User = new UserController().GetOne((int)row_entreprise["id"])!,
                            Score = Math.Round(score, 1),
                        });
                    }
                }
            }
            else if ((string)row["role"] == "entreprise")
            {
                var candidats = CustomQueries.QueryRoleUser("candidat", conn);

                foreach (DataRow row_candidat in candidats.GetTable().Rows)
                {
                    List<Apprentissage> dataApprentissagesCandidat = GetTableFromInvIdx<Apprentissage>(row_candidat, "invidx_apprentissages", "apprentissages");
                    List<Avantage> dataAvantagesCandidat = GetTableFromInvIdx<Avantage>(row_candidat, "invidx_avantages", "avantages");
                    List<Carriere> dataCarrieresCandidat = GetTableFromInvIdx<Carriere>(row_candidat, "invidx_carrieres", "carrieres");
                    List<Competence> dataCompetencesCandidat = GetTableFromInvIdx<Competence>(row_candidat, "invidx_competences", "competences");
                    List<Personnalite> dataPersonnalitesCandidat = GetTableFromInvIdx<Personnalite>(row_candidat, "invidx_personnalites", "personnalites");
                    List<ValeurEthique> dataValeursEthiquesCandidat = GetTableFromInvIdx<ValeurEthique>(row_candidat, "invidx_valeurs_ethiques", "valeurs_ethiques");

                    // Find common qualities
                    List<double> scores = [
                        FindCommonAsPercentage(dataApprentissages, dataApprentissagesCandidat, new IdComparer<Apprentissage>()),
                        FindCommonAsPercentage(dataAvantages, dataAvantagesCandidat, new IdComparer<Avantage>()),
                        FindCommonAsPercentage(dataCarrieres, dataCarrieresCandidat, new IdComparer<Carriere>()),
                        FindCommonAsPercentage(dataCompetences, dataCompetencesCandidat, new IdComparer<Competence>()),
                        FindCommonAsPercentage(dataPersonnalites, dataPersonnalitesCandidat, new IdComparer<Personnalite>()),
                        FindCommonAsPercentage(dataValeursEthiques, dataValeursEthiquesCandidat, new IdComparer<ValeurEthique>()),
                        row["types_contrat"].Equals(row_candidat["types_contrat"]) ? 100 : 0
                    ];
                    double score;
                    score = scores.Sum() / scores.Count;
                    // Add the result to the list
                    if (score > 0)
                    {
                        results.Add(new Matching
                        {
                            User = new UserController().GetOne((int)row_candidat["id"])!,
                            Score = Math.Round(score, 1),
                        });
                    }
                }
            }
            return results;
        }
    }
}
