using System.Data;
using talentz_api.Models;
using talentz_api.Sql;
using talentz_api.Sql.Statements;

namespace talentz_api.Controllers
{
    public class UserControllerBase : GeneralController
    {
        protected List<Qualite> GetQualites(DataRow row)
        {
            List<SqlStatement> queryStatementQualites = [
                    new SelectStatement("qualites", ["qualites.id","qualites.nom", new AsStatement("users.id","user_id").ToString()]),
                    new JoinStatement("users_qualites", "left", new OnStatement("qualites.id", "=", "users_qualites.id_qualite")),
                    new JoinStatement("users", "inner", new OnStatement("users_qualites.id_user", "=", "users.id")),
                    new WhereStatement(statements: ["users.id","=",((int)row["id"]).ToString()])
                ];
            SqlQuery sqlQuery = new(conn, queryStatementQualites, "qualites");

            sqlQuery.ExecuteGet();

            List<Qualite> dataQualites = [];

            foreach (DataRow row_qualite in sqlQuery.GetTable().Rows)
            {
                dataQualites.Add(new Qualite()
                {
                    Id = (int)row_qualite["id"],
                    Nom = (string)row_qualite["nom"]
                });
            }
            return dataQualites;
        }

        public List<int> GetIds()
        {

            List<SqlStatement> sqlStatements = [
                new SelectStatement("users", ["id"])
            ];

            SqlQuery query = new SqlQuery(conn, sqlStatements, "users");

            query.ExecuteGet();

            List<int> dataIds = [];

            foreach (DataRow row in query.GetTable().Rows)
            {
                dataIds.Add((int)row["id"]);
            }

            return dataIds;
        }
    }
}
