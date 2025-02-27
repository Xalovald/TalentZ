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
    [Route("/api/valeurs_ethiques")]
    public class ValeursEthiquesController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<ValeurEthique>))]
        public List<ValeurEthique> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("valeurs_ethiques", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "valeurs_ethiques");

            query.ExecuteGet();

            List<ValeurEthique> valeurs_ethiques = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                valeurs_ethiques.Add(new ValeurEthique()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return valeurs_ethiques;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<ValeurEthique>))]
        public ValeurEthique GetOne(string term)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("valeurs_ethiques", ["*"]),
                new WhereStatement(["valeurs_ethiques.text", "=", term]),
            ];

            SqlQuery query = new(conn, sqlStatements, "valeurs_ethiques");

            query.ExecuteGet();

            List<ValeurEthique> valeurs_ethiques = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                valeurs_ethiques.Add(new ValeurEthique()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return valeurs_ethiques[0];
        }

    }
}
