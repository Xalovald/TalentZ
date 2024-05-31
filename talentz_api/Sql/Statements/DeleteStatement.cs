namespace talentz_api.Sql.Statements
{
    public class DeleteStatement : SqlStatement
    {
        private readonly string _table;
        private readonly List<string> _fields;
        public DeleteStatement(string table, List<string> fields)
        {
            _table = table;
            _fields = fields;
        }

        public override string ToString()
        {
            _full = "DELETE ";

            _full += _fields.Count > 0 ? string.Join(',', _fields) + " " : "";

            _full += "FROM " + _table;

            return _full;
        }
    }
}
