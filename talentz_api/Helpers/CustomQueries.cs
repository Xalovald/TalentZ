using Google.Protobuf.WellKnownTypes;
using talentz_api.Models;
using talentz_api.Sql.Statements;
using talentz_api.Sql;
using MySql.Data.MySqlClient;

namespace talentz_api.Helpers
{
    public static class CustomQueries
    {
        public static SqlQuery QueryOneUser(int userId, MySqlConnection conn)
        {
            List<SqlStatement> queryStatementsUsers = [
                new SelectStatement("users", ["*"]),
                new WhereStatement(["users.id", "=", "@userId"]),
                new LimitStatement(1)
            ];

            SqlQuery sqlQueryUsers = new(conn, queryStatementsUsers, "users", [
                new PreparedParameter("@userId", userId)
            ]);

            sqlQueryUsers.ExecuteGet();

            return sqlQueryUsers;

        }

        public static SqlQuery QueryRoleUser(string role, MySqlConnection conn)
        {
            List<SqlStatement> queryStatementsUsers = [
                new SelectStatement("users", ["*"]),
                new WhereStatement(["users.role", "=", new TypedValue<string>(role).ToString()])
            ];

            SqlQuery sqlQueryUsers = new(conn, queryStatementsUsers, "users");

            sqlQueryUsers.ExecuteGet();

            return sqlQueryUsers;

        }

    }
}
