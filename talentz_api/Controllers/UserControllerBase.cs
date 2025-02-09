using Mysqlx.Crud;
using Mysqlx.Prepare;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using talentz_api.Sql;
using talentz_api.Sql.Statements;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace talentz_api.Controllers
{
    public class UserControllerBase : GeneralController
    {
        protected List<T> GetTableFromInvIdx<T>(DataRow row, string invidx_table, string target_table) where T : new()
        {
            List<SqlStatement> queryStatement = [
                    new SelectStatement(target_table, [target_table + ".id",target_table + ".text", new AsStatement("users.id","id_user").ToString()]),
                    new JoinStatement(invidx_table, "left", new OnStatement(target_table + ".id", "=", invidx_table + ".id_" + target_table.Remove(target_table.Length - 1))),
                    new JoinStatement("users", "inner", new OnStatement(invidx_table + ".id_user", "=", "users.id")),
                    new WhereStatement(statements: ["users.id","=",((int)row["id"]).ToString()])
                ];
            SqlQuery sqlQuery = new(conn, queryStatement, target_table);

            sqlQuery.ExecuteGet();

            List<T> data = [];

            foreach (DataRow innerRow in sqlQuery.GetTable().Rows)
            {
                T instance = new();
                PropertyInfo[] properties = typeof(T).GetProperties();
                foreach (PropertyInfo property in properties)
                {
                    var val = innerRow[property.Name.ToLower()];
                    if (property.CanWrite)
                    {
                        property.SetValue(instance, val);
                    }
                }
                data.Add(instance);
            }
            return data;
        }

        protected T? GetLinkedTable<T>(DataRow row, string target_table, string original_table) where T : new()
        {
            List<SqlStatement> queryStatement = [
                    new SelectStatement(target_table, [target_table + ".id",target_table + ".nom", original_table + "." + target_table.Remove(target_table.Length - 1)]),
                    new JoinStatement(original_table, "inner", new OnStatement(target_table + ".id", "=", original_table + "." + target_table.Remove(target_table.Length - 1))),
                    new WhereStatement(statements: [original_table + ".id", "=",((int)row["id"]).ToString()])
                ];
            SqlQuery sqlQuery = new(conn, queryStatement, target_table);

            sqlQuery.ExecuteGet();

            List<T> data = [];

            if (sqlQuery.GetTable().Rows.Count > 0 )
            {

                foreach (DataRow innerRow in sqlQuery.GetTable().Rows)
                {
                    T instance = new();
                    PropertyInfo[] properties = typeof(T).GetProperties();
                    foreach (PropertyInfo property in properties)
                    {
                        var val = innerRow[property.Name.ToLower()];
                        if (property.CanWrite)
                        {
                            property.SetValue(instance, val);
                        }
                    }
                    data.Add(instance);
                }
                return data[0];
            }
            else
            {
                return default;
            }
        }
        protected (List<SqlStatement>, List<PreparedParameter>) InsertStatementFromParamList(List<int> dataList)
        {
            List<SqlStatement> insertStatements = [];
            List<PreparedParameter> preparedParameters = [];
            int insertId = 0;
            foreach(int _obj in dataList)
            {
                if (insertId == 0)
                {
                    insertStatements.Add(
                        new ValuesStatement([
                            "@userId",
                            "@objId"
                        ])
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@userId", GetIds().Last())
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@objId", _obj)
                    );
                }
                else
                {
                    insertStatements.Add(
                    new InsertComma([
                            "@userId"+insertId,
                            "@objId"+insertId
                    ])
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@userId" + insertId, GetIds().Last())
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@objId" + insertId, _obj)
                    ); ;

                }
                insertId++;
            }
            return (insertStatements, preparedParameters);
        }

        protected void InsertInInvIdx(string table, bool execute, List<int> dataList)
        {
            if (dataList.Count > 0) {
                List<string> tableSplitted = [.. table.Split("_")];
                tableSplitted.RemoveAt(0);
                var reformTable = string.Join("_", tableSplitted);
                (List<SqlStatement> insertStatements, List<PreparedParameter> preparedParameters) = InsertStatementFromParamList(dataList);
                List<SqlStatement> sqlInvIdStatements = [
                    new InsertStatement(table, ["id_user", "id_" + reformTable.Remove(reformTable.Length - 1)]),
                    ..insertStatements
                ];
                SqlQuery sqlQueryInvId = new(conn, sqlInvIdStatements, table, preparedParameters);
                if (execute) sqlQueryInvId.ExecuteNonQuery();
            }
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
