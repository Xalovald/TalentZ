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
    public class MatchingController : GeneralController
    {
        public List<Matching> MatchUserWithEnterprises(int user_id)
        {
            var results = new List<Matching>();

            var userController = new UserController();

            var user = userController.GetOne(user_id);

            if(user.Role == "candidat")
            {
                var entreprises = userController.GetEntreprises();

                foreach (var enterprise in entreprises)
                {
                    // Find common qualities
                    var commonQualities = user.Qualites!.Intersect(enterprise.Qualites!).ToList();

                    // Calculate the score (number of common qualities)
                    var score = commonQualities.Count;

                    // Add the result to the list
                    results.Add(new Matching
                    {
                        IdEntreprise = enterprise.Id,
                        Score = score,
                        CommonQualites = commonQualities
                    });
                }
            }
            else if(user.Role == "entreprise")
            {
                var candidats = userController.GetCandidats();

                foreach (var candidat in candidats)
                {
                    // Find common qualities
                    var commonQualities = user.Qualites!.Intersect(candidat.Qualites!).ToList();

                    // Calculate the score (number of common qualities)
                    var score = commonQualities.Count;

                    // Add the result to the list
                    results.Add(new Matching
                    {
                        IdCandidat = candidat.Id,
                        Score = score,
                        CommonQualites = commonQualities
                    });
                }
            }
            
            return results;
        }
    }
}
