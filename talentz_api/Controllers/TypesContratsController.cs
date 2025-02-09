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
    [Route("/api/types_contrats")]
    public class TypesContratsController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<TypeContrat>))]
        public List<TypeContrat> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("types_contrats", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "types_contrats");

            query.ExecuteGet();

            List<TypeContrat> types_contrats = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                types_contrats.Add(new TypeContrat()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return types_contrats;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<TypeContrat>))]
        public TypeContrat GetOne(int id)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("types_contrats", ["*"]),
                new WhereStatement(["types_contrats.id", "=", id.ToString()]),
            ];

            SqlQuery query = new(conn, sqlStatements, "types_contrats");

            query.ExecuteGet();

            List<TypeContrat> types_contrats = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                types_contrats.Add(new TypeContrat()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return types_contrats[0];
        }

    }
}
