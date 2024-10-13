using Microsoft.AspNetCore.Mvc;
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
        public List<Matching> MatchUserWithEnterprises([FromBody] int userId)
        {
            var results = new List<Matching>();

            SqlQuery sqlQueryUsers = CustomQueries.QueryOneUser(userId, conn);

            DataRow row = sqlQueryUsers.GetTable().Rows[0];

            List<Qualite> dataQualites = GetQualites(row);

            if ((string)row["role"] == "candidat")
            {
                var entreprises = CustomQueries.QueryRoleUser("entreprise", conn);

                foreach (DataRow row_entreprise in entreprises.GetTable().Rows)
                {
                    List<Qualite> dataQualitesEntreprise = GetQualites(row_entreprise);
                    // Find common qualities
                    var commonQualities = dataQualites.Intersect(dataQualitesEntreprise).ToList();

                    // Calculate the score (number of common qualities)
                    var score = commonQualities.Count;

                    // Add the result to the list
                    results.Add(new Matching
                    {
                        IdEntreprise = (int)row_entreprise["id"],
                        Score = score,
                        CommonQualites = commonQualities
                    });
                }
            }
            else if ((string)row["role"] == "entreprise")
            {
                var candidats = CustomQueries.QueryRoleUser("candidat", conn);

                foreach (DataRow row_candidat in candidats.GetTable().Rows)
                {
                    List<Qualite> dataQualitesCandidat = GetQualites(row_candidat);
                    // Find common qualities
                    var commonQualities = dataQualites.Intersect(dataQualitesCandidat).ToList();

                    // Calculate the score (number of common qualities)
                    var score = commonQualities.Count;

                    // Add the result to the list
                    results.Add(new Matching
                    {
                        IdCandidat = (int)row_candidat["id"],
                        Score = score,
                        CommonQualites = commonQualities
                    });
                }
            }
            
            return results;
        }
    }
}
