using Microsoft.AspNetCore.Mvc;
using System.Data;
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
    [Route("/api/calendrier")]
    public class CalendrierController : GeneralController
    {
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Calendrier>))]
        public List<Calendrier> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("calendrier", ["*"])
            ];

            SqlQuery query = new(conn, sqlStatements, "calendrier");

            query.ExecuteGet();

            List<Calendrier> calendriers = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                calendriers.Add(new Calendrier()
                {
                    Id = (int)row["id"],
                    Date = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date"])),
                    Evenements = (string)row["evenements"],
                    Acteurs = (string)row["acteurs"]
                });
            }

            return calendriers;
        }

        [HttpGet("{Id}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Calendrier))]
        public Calendrier GetOne(int Id)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("calendrier", ["*"]),
                new WhereStatement(["id","=",Id.ToString()]),
                new LimitStatement(1)
            ];

            SqlQuery query = new(conn, sqlStatements, "calendrier");

            query.ExecuteGet();

            List<Calendrier> calendriers = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                calendriers.Add(new Calendrier()
                {
                    Id = (int)row["id"],
                    Date = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date"])),
                    Evenements = (string)row["evenements"],
                    Acteurs = (string)row["acteurs"]
                });
            }

            return calendriers[0];
        }


        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public void CreateCalendrier([FromBody] CalendrierData data)
        {
            List<SqlStatement> sqlStatements = [
                new InsertStatement("calendrier", ["date", "evenements", "acteurs"]),
                new ValuesStatement([
                    "@date",
                    "@evenements",
                    "@acteurs",
                ])

            ];

            SqlQuery sqlQuery = new(conn, sqlStatements, "calendrier", [
                new PreparedParameter("@date", data.Date),
                new PreparedParameter("@evenements", data.Evenements),
                new PreparedParameter("@acteurs", data.Acteurs),
            ]);

            sqlQuery.ExecuteNonQuery();

            Response.StatusCode = StatusCodes.Status201Created;
            Response.Headers.Location = "http://localhost:5212.api/calendrier";
        }

        [HttpPatch("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult PatchCalendrier(int Id, [FromBody] Calendrier data)
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
                new UpdateStatement("calendrier", [
                    data.Date != null ? new SetStatement("date", "@date").ToString() : "",
                    data.Evenements != null ? new SetStatement("evenements","@evenements").ToString() : "",
                    data.Acteurs != null ? new SetStatement("acteurs", "@acteurs").ToString() : "",
                ] ),
                new WhereStatement(["calendrier.id", "=", "@calendrierId"])
            ];

            SqlQuery query = new(conn, sqlStatements, "userPatch", [
                new PreparedParameter("@date", NotDefaultOrEmptyString<DateTime>(ConvertFromDBVal<DateTime>(data.Date!))),
                new PreparedParameter("@evenements", data.Evenements ?? ""),
                new PreparedParameter("@acteurs", data.Acteurs! ?? ""),
                new PreparedParameter("@calendrierId", Id)
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

        [HttpDelete("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult DeleteCalendrier(int Id)
        {
            List<SqlStatement> sqlStatements = [
                new DeleteStatement("calendrier", []),
                new WhereStatement(["calendrier.id", "=", "@idDelete"])
            ];

            SqlQuery query = new(conn, sqlStatements, "calendrierDelete", [
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
