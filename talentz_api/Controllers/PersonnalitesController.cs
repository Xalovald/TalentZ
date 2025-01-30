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
    [Route("/api/personnalites")]
    public class PersonnalitesController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Personnalite>))]
        public List<Personnalite> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("personnalites", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "personnalites");

            query.ExecuteGet();

            List<Personnalite> personnalites = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                personnalites.Add(new Personnalite()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return personnalites;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Personnalite>))]
        public Personnalite GetOne(string term)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("personnalites", ["*"]),
                new WhereStatement(["personnalites.text", "=", term]),
            ];

            SqlQuery query = new(conn, sqlStatements, "personnalites");

            query.ExecuteGet();

            List<Personnalite> personnalites = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                personnalites.Add(new Personnalite()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return personnalites[0];
        }

    }
}
