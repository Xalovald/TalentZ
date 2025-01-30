using Microsoft.AspNetCore.Mvc;
using Mysqlx.Expr;
using System.Data;
using talentz_api.Accessing;
using talentz_api.DataRequests;
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
        public List<Matching> MatchUserWithEnterprises([FromBody] MatchingData matchingData)
        {
            var results = new List<Matching>();

            SqlQuery sqlQueryUsers = CustomQueries.QueryOneUser(matchingData.IdUser, conn);

            DataRow row = sqlQueryUsers.GetTable().Rows[0];

            List<Apprentissage> dataApprentissages = GetTableFromInvIdx<Apprentissage>(row, "invidx_apprentissages", "apprentissages");

            if ((string)row["role"] == "candidat")
            {
                var entreprises = CustomQueries.QueryRoleUser("entreprise", conn);

                foreach (DataRow row_entreprise in entreprises.GetTable().Rows)
                {
                    List<Apprentissage> dataApprentissagesEntreprise = GetTableFromInvIdx<Apprentissage>(row_entreprise, "invidx_apprentissages", "apprentissages");
                    // Find common qualities
                    var commonQualites = new List<Apprentissage>();
                    dataApprentissages.ConvertAll(new Converter<Apprentissage, Apprentissage>(
                        qualite => {
                            if (dataApprentissagesEntreprise.Exists(pre => pre.Id == qualite.Id))
                            {
                                commonQualites.Add(qualite);
                            }
                            return qualite;
                            }
                        ));

                    // Calculate the score (number of common qualities)
                    var score = commonQualites.Count;

                    // Add the result to the list
                    results.Add(new Matching
                    {
                        IdEntreprise = (int)row_entreprise["id"],
                        Score = score,
                        CommonQualites = commonQualites
                    });
                }
            }
            else if ((string)row["role"] == "entreprise")
            {
                var candidats = CustomQueries.QueryRoleUser("candidat", conn);

                foreach (DataRow row_candidat in candidats.GetTable().Rows)
                {
                    List<Apprentissage> dataApprentissagesCandidat = GetTableFromInvIdx<Apprentissage>(row_candidat, "invidx_apprentissages", "apprentissages");
                    // Find common qualities
                    var commonApprentissages = dataApprentissages.Intersect(dataApprentissagesCandidat).ToList();

                    // Calculate the score (number of common qualities)
                    var score = commonApprentissages.Count;

                    // Add the result to the list
                    results.Add(new Matching
                    {
                        IdCandidat = (int)row_candidat["id"],
                        Score = score,
                        CommonQualites = commonApprentissages
                    });
                }
            }
            
            return results;
        }
    }
}
