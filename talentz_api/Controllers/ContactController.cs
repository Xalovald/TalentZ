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
    [Route("/api/contacts")]
    public class ContactController : GeneralController
    {
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Contact>))]
        public List<Contact> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("contact", ["*"])
            ];

            SqlQuery query = new(conn, sqlStatements, "contacts");

            query.ExecuteGet();

            List<Contact> contacts = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                contacts.Add(new Contact()
                {
                    Id = (int)row["id"],
                    Date = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date"])),
                    Mail = (string)row["mail"],
                    Message = (string)row["message"],
                    Objet = (string)row["objet"]

                });
            }

            return contacts;
        }

        [HttpGet("{Id}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Contact))]
        public Contact GetOne(int Id)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("contact", ["*"]),
                new WhereStatement(["id","=",Id.ToString()]),
                new LimitStatement(1)
            ];

            SqlQuery query = new(conn, sqlStatements, "contacts");

            query.ExecuteGet();

            List<Contact> contacts = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                contacts.Add(new Contact()
                {
                    Id = (int)row["id"],
                    Date = NotDefaultOrNull<DateTime>(ConvertFromDBVal<DateTime>(row["date"])),
                    Mail = (string)row["mail"],
                    Message = (string)row["message"],
                    Objet = (string)row["objet"]

                });
            }

            return contacts[0];
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(void))]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public void CreateContact([FromBody] ContactData data)
        {
            List<SqlStatement> sqlStatements = [
                new InsertStatement("contact", ["date", "mail", "message", "objet"]),
                new ValuesStatement([
                    "@date",
                    "@mail",
                    "@message",
                    "@objet",
                ])

            ];

            SqlQuery sqlQuery = new(conn, sqlStatements, "users", [
                new PreparedParameter("@date", data.Date),
                new PreparedParameter("@mail", data.Mail),
                new PreparedParameter("@message", data.Message),
                new PreparedParameter("@objet", data.Objet),
            ]);

            sqlQuery.ExecuteNonQuery();

            Response.StatusCode = StatusCodes.Status201Created;
            Response.Headers.Location = "http://localhost:5212.api/contacts";
        }

        [HttpPatch("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult PatchContact(int Id, [FromBody] Contact data)
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
                new UpdateStatement("contact", [
                    data.Date != null ? new SetStatement("date", "@date").ToString() : "",
                    data.Mail != null ? new SetStatement("mail","@mail").ToString() : "",
                    data.Message != null ? new SetStatement("message", "@message").ToString() : "",
                    data.Objet != null ? new SetStatement("objet","@objet").ToString() : ""
                ] ),
                new WhereStatement(["contact.id", "=", "@contactId"])
            ];

            SqlQuery query = new(conn, sqlStatements, "userPatch", [
                new PreparedParameter("@date", NotDefaultOrEmptyString<DateTime>(ConvertFromDBVal<DateTime>(data.Date!))),
                new PreparedParameter("@mail", data.Mail ?? ""),
                new PreparedParameter("@message", data.Message ?? ""),
                new PreparedParameter("@objet",data.Objet ?? ""),
                new PreparedParameter("@contactId", Id),
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
        public IActionResult DeleteContact([FromQuery] int? userId, int Id)
        {
            List<SqlStatement> sqlStatements = [
                new DeleteStatement("contact", []),
                new WhereStatement(["contact.id", "=", "@idDelete"])
            ];

            SqlQuery query = new(conn, sqlStatements, "contactDelete", [
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
