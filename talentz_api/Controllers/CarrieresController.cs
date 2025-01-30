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
    [Route("/api/carrieres")]
    public class CarrieresController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Carriere>))]
        public List<Carriere> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("carrieres", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "carrieres");

            query.ExecuteGet();

            List<Carriere> carrieres = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                carrieres.Add(new Carriere()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return carrieres;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<Carriere>))]
        public Carriere GetOne(string term)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("carrieres", ["*"]),
                new WhereStatement(["carrieres.text", "=", term]),
            ];

            SqlQuery query = new(conn, sqlStatements, "carrieres");

            query.ExecuteGet();

            List<Carriere> carrieres = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                carrieres.Add(new Carriere()
                {
                    Id = (int)row["id"],
                    Text = (string)row["text"]
                });
            }

            return carrieres[0];
        }

    }
}
