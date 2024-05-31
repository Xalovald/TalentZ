using MySql.Data.MySqlClient;
using System.Data;
using talentz_api.Sql.Statements;

namespace talentz_api.Sql
{
    public class SqlQuery
    {
        private readonly MySqlConnection _conn;
        private readonly List<SqlStatement> _query;
        private readonly string _table;
        private readonly List<PreparedParameter> _preparedParameters;
        private DataTable _dataTable = new();
        private string _fullQuery = "";
        private MySqlCommand _cmd = new();

        public SqlQuery(MySqlConnection conn, List<SqlStatement> query, string table, List<PreparedParameter>? preparedParameters = null)
        {
            _conn = conn;
            _query = query;
            _table = table;
            _preparedParameters = preparedParameters ?? [];
            DoQuery();
        }
        private void DoQuery()
        {

            _fullQuery = "";
            foreach (SqlStatement statement in _query)
            {
                _fullQuery += statement.ToString() + " ";
            }
            _cmd = new(string.Concat(_fullQuery.AsSpan(0, _fullQuery.Length - 1), ";"), _conn);

            if (_preparedParameters.Count > 0)
            {
                foreach (PreparedParameter param in _preparedParameters)
                {
                    _cmd.Parameters.AddWithValue(param.parameterName, param.value);
                }
                _conn?.Open();
                _cmd.Prepare();
                _conn?.Close();
            }
        }

        public void ExecuteGet()
        {
            DataTable dataTable = new(_table);
            MySqlDataAdapter dap = new(_cmd);

            _conn?.Open();
            dap.Fill(dataTable);
            _conn?.Close();

            _dataTable = dataTable;
        }

        public int ExecuteNonQuery()
        {
            _conn?.Open();
            int result = _cmd.ExecuteNonQuery();
            _conn?.Close();
            return result;
        }

        public DataTable GetTable()
        {
            return _dataTable;
        }

        public override string ToString()
        {
            return _fullQuery;
        }
    }
}
