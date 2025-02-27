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
    [Route("/api/questions_mysteres")]
    public class QuestionsMysteresController : GeneralController
    {
        [HttpGet("random")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Apprentissage>))]
        public QuestionMystere GetRandom()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("questions_mysteres", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "questions_mysteres");

            query.ExecuteGet();
            DataRow row = query.GetTable().Rows[new Random().Next(0, query.GetTable().Rows.Count)];
            return new QuestionMystere()
            {
                Id = (int)row["id"],
                Text = (string)row["text"]
            };
        }

    }
}
