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
    [Route("/api/missions")]
    public class MissionsController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Mission>))]
        public List<Mission> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("missions", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "missions");

            query.ExecuteGet();

            List<Mission> missions = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                missions.Add(new Mission()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return missions;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Mission>))]
        public Mission GetOne(string term)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("missions", ["*"]),
                new WhereStatement(["missions.text", "=", term]),
            ];

            SqlQuery query = new(conn, sqlStatements, "missions");

            query.ExecuteGet();

            List<Mission> missions = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                missions.Add(new Mission()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return missions[0];
        }

    }
}
