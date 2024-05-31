namespace talentz_api.Sql.Statements
{
    public class AsStatement(string field, string new_name) : SqlStatement
    {
        private readonly string _field = field;
        private readonly string _new_name = new_name;

        public override string ToString()
        {
            _full = _field + " AS " + _new_name;
            return _full;
        }
    }
}
