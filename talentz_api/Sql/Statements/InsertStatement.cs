namespace talentz_api.Sql.Statements
{
    public class InsertStatement(string tableName, List<string> fields) : SqlStatement
    {
        private readonly string _tableName = tableName;
        private readonly List<string> _fields = fields;

        public override string ToString()
        {
            _full = "INSERT INTO " + _tableName;

            _full += "(";

            _full += string.Join(',', _fields);

            _full += ")";

            return _full;
        }
    }
}
