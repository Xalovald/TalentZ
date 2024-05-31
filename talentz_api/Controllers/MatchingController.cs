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
        [AdminAccess]
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Matching>))]
        public List<Matching> GetAll([FromQuery] int? userId)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("matching", ["*"])
            ];

            SqlQuery query = new(conn, sqlStatements, "matching");

            query.ExecuteGet();

            List<Matching> matchings = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                matchings.Add(new Matching()
                {
                    Id = (int)row["id"],
                    IdEntreprise = (int)row["id_entreprise"],
                    IdCandidat = (int)row["id_candidat"],
                    Date = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date"]))
                });
            }

            return matchings;
        }

        [AdminAccess]
        [HttpGet("{Id}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Matching))]
        public Matching GetOne(int Id, [FromQuery] int? userId)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("matching", ["*"]),
                new WhereStatement(["id","=",Id.ToString()]),
                new LimitStatement(1)
            ];

            SqlQuery query = new(conn, sqlStatements, "matching");

            query.ExecuteGet();

            List<Matching> matchings = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                matchings.Add(new Matching()
                {
                    Id = (int)row["id"],
                    IdEntreprise = (int)row["id_entreprise"],
                    IdCandidat = (int)row["id_candidat"],
                    Date = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date"]))
                });
            }

            return matchings[0];
        }


        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public void CreateMatching([FromBody] MatchingData data)
        {
            List<SqlStatement> sqlStatements = [
                new InsertStatement("matching", ["id_entreprise", "id_candidat", "date"]),
                new ValuesStatement([
                    "@idEntreprise",
                    "@idCandidat",
                    "@date",
                ])

            ];

            SqlQuery sqlQuery = new(conn, sqlStatements, "users", [
                new PreparedParameter("@idEntreprise", data.IdEntreprise),
                new PreparedParameter("@idCandidat", data.IdCandidat),
                new PreparedParameter("@date", data.Date),
            ]);

            sqlQuery.ExecuteNonQuery();

            Response.StatusCode = StatusCodes.Status201Created;
            Response.Headers.Location = "http://localhost:5212.api/matching";
        }

        [AdminAccess]
        [HttpPatch("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult PatchMatching(int Id, [FromBody] Matching data, [FromQuery] int? userId)
        {
            if (data == null || !data.GetType().GetProperties().Any(p => p.GetValue(data) != null))
            {
                return BadRequest(new
                {
                    Type = RfcLinks.BadRequest,
                    Title = "Bad Request",
                    Status = StatusCodes.Status400BadRequest,
                    TraceId = Guid.NewGuid(),
                    Message = "No field provided for update.",
                });
            }
            List<SqlStatement> sqlStatements = [
                new UpdateStatement("matching", [
                    data.Date != null ? new SetStatement("date", "@date").ToString() : "",
                    data.IdEntreprise != null ? new SetStatement("id_entreprise","@idEntreprise").ToString() : "",
                    data.IdCandidat != null ? new SetStatement("id_candidat", "@idCandidat").ToString() : "",
                ] ),
                new WhereStatement(["matching.id", "=", "@matchingId"])
            ];

            SqlQuery query = new(conn, sqlStatements, "userPatch", [
                new PreparedParameter("@date", NotDefaultOrEmptyString<DateTime>(ConvertFromDBVal<DateTime>(data.Date!))),
                new PreparedParameter("@idEntreprise", NotDefaultOrEmptyString<int>(ConvertFromDBVal<int>(data.IdEntreprise!))),
                new PreparedParameter("@idCandidat", NotDefaultOrEmptyString<int>(ConvertFromDBVal<int>(data.IdCandidat!))),
                new PreparedParameter("@matchingId", Id)
            ]);

            int rowsAffected = query.ExecuteNonQuery();

            if (rowsAffected == 0)
            {
                return NotFound(new
                {
                    Type = RfcLinks.BadRequest,
                    Title = "Bad Request",
                    Status = StatusCodes.Status400BadRequest,
                    TraceId = Guid.NewGuid(),
                    Message = "No Id provided.",
                });
            }

            return NoContent();
        }

        [AdminAccess]
        [HttpDelete("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult DeleteMatching([FromQuery] int? userId, int Id)
        {
            List<SqlStatement> sqlStatements = [
                new DeleteStatement("matching", []),
                new WhereStatement(["matching.id", "=", "@idDelete"])
            ];

            SqlQuery query = new(conn, sqlStatements, "matchingDelete", [
                new PreparedParameter("@idDelete", Id)
            ]);

            int rowsAffected = query.ExecuteNonQuery();

            if (rowsAffected == 0)
            {
                return NotFound(new
                {
                    Type = RfcLinks.NotFound,
                    Title = "Not Found",
                    Status = StatusCodes.Status404NotFound,
                    TraceId = Guid.NewGuid(),
                    Message = "User not found.",
                });
            };

            return NoContent();
        }
    }
}
