using MySql.Data.MySqlClient;

namespace talentz_api.Sql
{
    public class SqlConn
    {
        private readonly string? _uid;
        private readonly string? _pwd;
        private readonly string? _database;
        private readonly string? _server = Environment.GetEnvironmentVariable("SERVER");
        private MySqlConnection _conn = new();
        public SqlConn(string? database, string? uid = "root", string? pwd = "root")
        {
            _uid = uid;
            _pwd = pwd;
            _database = database;
            Connect();
        }

        public MySqlConnection GetConn() { return _conn; }

        private void Connect()
        {
            _conn = new MySqlConnection(
                $"server={_server};" +
                $"uid={_uid};" +
                $"pwd={_pwd};" +
                $"database={_database};"
            );
        }
    }
}
