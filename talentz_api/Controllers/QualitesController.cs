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
    [Route("/api/qualites")]
    public class QualitesController : GeneralController
    {
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Qualite>))]
        public List<Qualite> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("qualites", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "qualites");

            query.ExecuteGet();

            List<Qualite> qualites = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                qualites.Add(new Qualite()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return qualites;
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Qualite>))]
        public Qualite GetOne(string term)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("qualites", ["*"]),
                new WhereStatement(["qualites.nom", "=", term]),
            ];

            SqlQuery query = new(conn, sqlStatements, "qualites");

            query.ExecuteGet();

            List<Qualite> qualites = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                qualites.Add(new Qualite()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return qualites[0];
        }

    }
}
