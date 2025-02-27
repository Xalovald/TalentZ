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
    [Route("/api/apprentissages")]
    public class ApprentissagesController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Apprentissage>))]
        public List<Apprentissage> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("apprentissages", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "apprentissages");

            query.ExecuteGet();

            List<Apprentissage> apprentissages = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                apprentissages.Add(new Apprentissage()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return apprentissages;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Apprentissage>))]
        public Apprentissage GetOne(int id)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("apprentissages", ["*"]),
                new WhereStatement(["apprentissages.id", "=", id.ToString()]),
            ];

            SqlQuery query = new(conn, sqlStatements, "apprentissages");

            query.ExecuteGet();

            List<Apprentissage> apprentissages = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                apprentissages.Add(new Apprentissage()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return apprentissages[0];
        }

    }
}
