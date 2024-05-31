namespace talentz_api.Sql.Statements
{
    public class SelectStatement(string table, List<string> fields) : SqlStatement
    {
        private readonly string _table = table;
        private readonly List<string> _fields = fields;

        public override string ToString()
        {
            _full = "SELECT ";
            foreach (string field in _fields)
            {
                _full += $"{field},";
            }
            _full = _full.Remove(_full.LastIndexOf(','));

            _full += " FROM ";
            _full += _table;
            return _full;
        }
    }
}
