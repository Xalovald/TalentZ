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
    [Route("/api/messagerie")]
    public class MessagerieController : GeneralController
    {
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Messagerie>))]
        public List<Messagerie> GetAll([FromQuery] int? userId)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("messagerie", ["*"])
            ];

            SqlQuery query = new(conn, sqlStatements, "messagerie");

            query.ExecuteGet();

            List<Messagerie> messageries = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                messageries.Add(new Messagerie()
                {
                    Id = (int)row["id"],
                    IdDestinataire = (int)row["id_destinataire"],
                    IdEnvoyeur = (int)row["id_envoyeur"],
                    Message = (string)row["message"],
                    DateEnvoi = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date_envoi"]))
                });
            }

            return messageries;
        }

        [HttpGet("{Id}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Messagerie))]
        public Messagerie GetOne(int Id, [FromQuery] int? userId)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("messagerie", ["*"]),
                new WhereStatement(["id","=",Id.ToString()]),
                new LimitStatement(1)
            ];

            SqlQuery query = new(conn, sqlStatements, "messagerie");

            query.ExecuteGet();

            List<Messagerie> messageries = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                messageries.Add(new Messagerie()
                {
                    Id = (int)row["id"],
                    IdDestinataire = (int)row["id_destinataire"],
                    IdEnvoyeur = (int)row["id_envoyeur"],
                    Message = (string)row["message"],
                    DateEnvoi = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date_envoi"]))
                });
            }

            return messageries[0];
        }


        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public void CreateMessagerie([FromBody] MessagerieData data)
        {
            List<SqlStatement> sqlStatements = [
                new InsertStatement("messagerie", ["id_destinataire", "id_envoyeur", "message", "date_envoi"]),
                new ValuesStatement([
                    "@idDestinataire",
                    "@idEnvoyeur",
                    "@message",
                    "@dateEnvoi"
                ])

            ];

            SqlQuery sqlQuery = new(conn, sqlStatements, "users", [
                new PreparedParameter("@idDestinataire", data.IdDestinataire),
                new PreparedParameter("@idEnvoyeur", data.IdEnvoyeur),
                new PreparedParameter("@message", data.Message),
                new PreparedParameter("@dateEnvoi", data.DateEnvoi)
            ]);

            sqlQuery.ExecuteNonQuery();

            Response.StatusCode = StatusCodes.Status201Created;
            Response.Headers.Location = "http://localhost:5212.api/messagerie";
        }

        [AdminAccess]
        [HttpPatch("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult PatchMessagerie(int Id, [FromBody] Messagerie data, [FromQuery] int? userId)
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
                new UpdateStatement("messagerie", [
                    data.DateEnvoi != null ? new SetStatement("date_envoi", "@dateEnvoi").ToString() : "",
                    data.IdDestinataire != null ? new SetStatement("id_destinaire","@idDestinaire").ToString() : "",
                    data.IdEnvoyeur != null ? new SetStatement("id_envoyeur", "@idEnvoyeur").ToString() : "",
                    data.Message != null ? new SetStatement("message", "@message").ToString() : ""
                ] ),
                new WhereStatement(["messagerie.id", "=", "@messagerieId"])
            ];

            SqlQuery query = new(conn, sqlStatements, "userPatch", [
                new PreparedParameter("@dateEnvoi", NotDefaultOrEmptyString<DateTime>(ConvertFromDBVal<DateTime>(data.DateEnvoi!))),
                new PreparedParameter("@idDestinataire", NotDefaultOrEmptyString<int>(ConvertFromDBVal<int>(data.IdDestinataire!))),
                new PreparedParameter("@idEnvoyeur", NotDefaultOrEmptyString<int>(ConvertFromDBVal<int>(data.IdEnvoyeur!))),
                new PreparedParameter("@message", data.Message ?? ""),
                new PreparedParameter("@messagerieId", Id)
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
        public IActionResult DeleteMessagerie([FromQuery] int? userId, int Id)
        {
            List<SqlStatement> sqlStatements = [
                new DeleteStatement("messagerie", []),
                new WhereStatement(["messagerie.id", "=", "@idDelete"])
            ];

            SqlQuery query = new(conn, sqlStatements, "messagerieDelete", [
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
