namespace talentz_api.Sql.Statements
{
    public class WhereStatement(List<string> statements) : SqlStatement
    {
        private readonly List<string> _statements = statements;

        public override string ToString()
        {
            _full = "WHERE ";
            foreach (var statement in _statements)
            {
                _full += statement + " ";
            }
            _full = _full[..^1];
            return _full;
        }
    }
}
