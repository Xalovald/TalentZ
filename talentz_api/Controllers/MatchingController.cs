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
            List<Mission> dataMissions = GetTableFromInvIdx<Mission>(row, "invidx_missions", "missions");
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
                    List<Mission> dataMissionsEntreprise = GetTableFromInvIdx<Mission>(row_entreprise, "invidx_missions", "missions");
                    List<Personnalite> dataPersonnalitesEntreprise = GetTableFromInvIdx<Personnalite>(row_entreprise, "invidx_personnalites", "personnalites");
                    List<ValeurEthique> dataValeursEthiquesEntreprise = GetTableFromInvIdx<ValeurEthique>(row_entreprise, "invidx_valeurs_ethiques", "valeurs_ethiques");
                    var testVal1 = row["types_contrat"];
                    var testVal2 = row_entreprise["types_contrat"];
                    // Find common qualities
                    List<double> scores = [
                        FindCommonAsPercentage(dataApprentissages, dataApprentissagesEntreprise, x => x.Id!),
                        FindCommonAsPercentage(dataAvantages, dataAvantagesEntreprise, x => x.Id!),
                        FindCommonAsPercentage(dataCarrieres, dataCarrieresEntreprise, x => x.Id!),
                        FindCommonAsPercentage(dataCompetences, dataCompetencesEntreprise, x => x.Id!),
                        FindCommonAsPercentage(dataMissions, dataMissionsEntreprise, x => x.Id!),
                        FindCommonAsPercentage(dataPersonnalites, dataPersonnalitesEntreprise, x => x.Id!),
                        FindCommonAsPercentage(dataValeursEthiques, dataValeursEthiquesEntreprise, x => x.Id!),
                        row["types_contrat"].Equals(row_entreprise["types_contrat"]) ? 100 : 0
                    ];
                    double score;
                    score = scores.Sum() / scores.Count;
                    // Add the result to the list
                    if (score > 0)
                    {
                        results.Add(new Matching
                        {
                            IdEntreprise = (int)row_entreprise["id"],
                            Score = Math.Round(score),
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
                    List<Mission> dataMissionsCandidat = GetTableFromInvIdx<Mission>(row_candidat, "invidx_missions", "missions");
                    List<Personnalite> dataPersonnalitesCandidat = GetTableFromInvIdx<Personnalite>(row_candidat, "invidx_personnalites", "personnalites");
                    List<ValeurEthique> dataValeursEthiquesCandidat = GetTableFromInvIdx<ValeurEthique>(row_candidat, "invidx_valeurs_ethiques", "valeurs_ethiques");

                    // Find common qualities
                    List<double> scores = [
                        FindCommonAsPercentage(dataApprentissages, dataApprentissagesCandidat, x => x.Id!),
                        FindCommonAsPercentage(dataAvantages, dataAvantagesCandidat, x => x.Id!),
                        FindCommonAsPercentage(dataCarrieres, dataCarrieresCandidat, x => x.Id!),
                        FindCommonAsPercentage(dataCompetences, dataCompetencesCandidat, x => x.Id!),
                        FindCommonAsPercentage(dataMissions, dataMissionsCandidat, x => x.Id!),
                        FindCommonAsPercentage(dataPersonnalites, dataPersonnalitesCandidat, x => x.Id!),
                        FindCommonAsPercentage(dataValeursEthiques, dataValeursEthiquesCandidat, x => x.Id!),
                        row["types_contrat"].Equals(row_candidat["types_contrat"]) ? 100 : 0
                    ];
                    double score;
                    score = scores.Sum() / scores.Count;
                    // Add the result to the list
                    results.Add(new Matching
                    {
                        IdCandidat = (int)row_candidat["id"],
                        Score = Math.Round(score, 1),
                    });
                }
            }
            
            return results;
        }
    }
}
