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
    [Route("/api/company_sizes")]
    public class CompanySizesController : GeneralController
    {
        [HttpGet(Order = 1)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<CompanySize>))]
        public List<CompanySize> GetAll()
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("company_sizes", ["*"]),
            ];

            SqlQuery query = new(conn, sqlStatements, "company_sizes");

            query.ExecuteGet();

            List<CompanySize> company_sizes = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                company_sizes.Add(new CompanySize()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return company_sizes;
        }

        [HttpGet(Order = 2)]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<CompanySize>))]
        public CompanySize GetOne(int id)
        {
            List<SqlStatement> sqlStatements = [
                new SelectStatement("company_sizes", ["*"]),
                new WhereStatement(["company_sizes.id", "=", id.ToString()]),
            ];

            SqlQuery query = new(conn, sqlStatements, "company_sizes");

            query.ExecuteGet();

            List<CompanySize> company_sizes = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                company_sizes.Add(new CompanySize()
                {
                    Id = (int)row["id"],
                    Nom = (string)row["nom"]
                });
            }

            return company_sizes[0];
        }

    }
}
