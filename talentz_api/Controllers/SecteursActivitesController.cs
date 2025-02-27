using Microsoft.AspNetCore.Mvc;
using System.Data;
using talentz_api.Models;
using talentz_api.Sql.Statements;
using talentz_api.Sql;
using Xunit.Abstractions;

namespace talentz_api.Controllers
{
    [ApiController]
    [Produces("application/json")]
    [Consumes("application/json")]
    [Route("/api/secteurs_activites")]
    public class SecteursActivitesController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<SecteurActivite>))]
        public List<SecteurActivite> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("secteurs_activites", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "secteurs_activites");

            query.ExecuteGet();

            List<SecteurActivite> secteurs_activites = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                secteurs_activites.Add(new SecteurActivite()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return secteurs_activites;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<SecteurActivite>))]
        public SecteurActivite GetOne(int id)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("secteurs_activites", ["*"]),
                new WhereStatement(["secteurs_activites.id", "=", id.ToString()]),
            ];

            SqlQuery query = new(conn, sqlStatements, "secteurs_activites");

            query.ExecuteGet();

            List<SecteurActivite> secteurs_activites = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                secteurs_activites.Add(new SecteurActivite()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return secteurs_activites[0];
        }

    }
}
