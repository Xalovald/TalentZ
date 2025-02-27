namespace talentz_api.Sql.Statements
{
    public class OrderByStatement : SqlStatement
    {
        private readonly string _field;
        private readonly string _order;
        public OrderByStatement(string field, string order)
        {
            _field = field;
            _order = order;
        }

        public override string ToString()
        {
            _full = "ORDER BY ";

            _full += _field + " ";

            _full += _order;

            return _full;
        }
    }
}
