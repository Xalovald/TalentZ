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
    [Route("/api/competences")]
    public class CompetencesController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Competence>))]
        public List<Competence> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("competences", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "competences");

            query.ExecuteGet();

            List<Competence> competences = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                competences.Add(new Competence()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return competences;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Competence>))]
        public Competence GetOne(string term)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("competences", ["*"]),
                new WhereStatement(["competences.text", "=", term]),
            ];

            SqlQuery query = new(conn, sqlStatements, "competences");

            query.ExecuteGet();

            List<Competence> competences = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                competences.Add(new Competence()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return competences[0];
        }

    }
}
