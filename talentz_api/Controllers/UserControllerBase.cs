using Microsoft.IdentityModel.Tokens;
using Mysqlx.Crud;
using Mysqlx.Prepare;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using talentz_api.Helpers;
using talentz_api.Models;
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
                    new SelectStatement(target_table, ["*"]),
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
                    new SelectStatement(target_table, ["*"]),
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
        protected (List<SqlStatement>, List<PreparedParameter>) InsertStatementFromParamList(List<int?> dataList, List<Dictionary<string, dynamic>> additionalFields)
        {
            List<SqlStatement> insertStatements = [];
            List<PreparedParameter> preparedParameters = [];
            int insertId = 0;
            foreach(int? _obj in dataList)
            {
                List<string> additionalNames = [];
                List<dynamic> additionalValues = [];
                foreach(Dictionary<string, dynamic> _addObj in additionalFields)
                {
                    additionalNames = _addObj.Select(e => "@value"+e.Key).ToList();
                    additionalValues = _addObj.Select(e => e.Value).ToList();
                }
                if(_obj == null) continue;
                if (insertId == 0)
                {
                    insertStatements.Add(
                        new ValuesStatement([
                            "@userId",
                            "@objId",
                            !additionalFields.IsNullOrEmpty() ? additionalNames.First() : null
                        ])
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@userId", GetIds().First())
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@objId", _obj)
                    );
                    if(!additionalFields.IsNullOrEmpty()) {
                        preparedParameters.Add(
                            new PreparedParameter(additionalNames.First(), additionalValues.First())
                        );
                    };
                }
                else
                {
                    insertStatements.Add(
                    new InsertComma([
                            "@userId"+insertId,
                            "@objId"+insertId,
                            !additionalFields.IsNullOrEmpty() ? additionalNames.First() : null
                    ])
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@userId" + insertId, GetIds().First())
                    );
                    preparedParameters.Add(
                        new PreparedParameter("@objId" + insertId, _obj)
                    );
                    if (!additionalFields.IsNullOrEmpty())
                    {
                        preparedParameters.Add(
                            new PreparedParameter(additionalNames.First(), additionalValues.First())
                        );
                    };

                }
                insertId++;
            }
            return (insertStatements, preparedParameters);
        }

        protected void InsertInInvIdx(string table, bool execute, List<int?> dataList, List<Dictionary<string, dynamic>>? additionalFields = null)
        {
            if (dataList.Count > 0) {
                List<string> tableSplitted = [.. table.Split("_")];
                tableSplitted.RemoveAt(0);
                var reformTable = string.Join("_", tableSplitted);
                additionalFields ??= [];
                List<string> additionalNames = additionalFields.Select((e, id) => e.Keys.ToList()[id]).ToList();
                (List<SqlStatement> insertStatements, List<PreparedParameter> preparedParameters) = InsertStatementFromParamList(dataList, additionalFields);
                List<SqlStatement> sqlInvIdStatements = [
                    new InsertStatement(table, ["id_user", "id_" + reformTable.Remove(reformTable.Length - 1), ..additionalNames]),
                    ..insertStatements,
                ];
                SqlQuery sqlQueryInvId = new(conn, sqlInvIdStatements, table, preparedParameters);
                if (execute) sqlQueryInvId.ExecuteNonQuery();
            }
        }

        public List<int> GetIds()
        {

            List<SqlStatement> sqlStatements = [
                new SelectStatement("users", ["id"]),
                new OrderByStatement("id", "DESC")
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

        protected double FindCommonAsPercentage<T>(List<T> compared, List<T> comparator, Helpers.IComparer<T> comparer)
        {
            double percentage = 0;
            List<T> commonFields = compared.Intersect(comparator, comparer).ToList();
            if (commonFields.Count > 0)
            {
                percentage = (double)commonFields.Count / compared.Count * 100;
            }
            return percentage;
        }
    }
}
