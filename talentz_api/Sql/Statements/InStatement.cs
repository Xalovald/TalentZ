namespace talentz_api.Sql.Statements
{
    public class InStatement : SqlStatement
    {
        private readonly List<string> _checks;
        public InStatement(List<string> checks)
        {
            _checks = checks;
        }

        public override string ToString()
        {
            _full = "IN ";

            _full += "(";

            _full += string.Join(',', _checks);

            _full += ")";

            return _full;
        }
    }
}
