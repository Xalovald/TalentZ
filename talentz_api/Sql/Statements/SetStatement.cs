namespace talentz_api.Sql.Statements
{
    public class SetStatement(string field, string value) : SqlStatement
    {
        private readonly string _field = field;
        private readonly string _value = value;

        public override string ToString()
        {
            _full = "SET ";

            _full += _field;

            _full += " = ";

            _full += _value;

            return _full;
        }
    }
}
