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
    [Route("/api/avantages")]
    public class AvantagesController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Avantage>))]
        public List<Avantage> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("avantages", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "avantages");

            query.ExecuteGet();

            List<Avantage> avantages = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                avantages.Add(new Avantage()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return avantages;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Avantage>))]
        public Avantage GetOne(string term)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("avantages", ["*"]),
                new WhereStatement(["avantages.text", "=", term]),
            ];

            SqlQuery query = new(conn, sqlStatements, "avantages");

            query.ExecuteGet();

            List<Avantage> avantages = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                avantages.Add(new Avantage()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return avantages[0];
        }

    }
}
