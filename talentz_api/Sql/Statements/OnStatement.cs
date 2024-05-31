namespace talentz_api.Sql.Statements
{
    public class OnStatement(string left_field, string bin_op, string right_field) : SqlStatement
    {
        private readonly string _left_field = left_field;
        private readonly string _bin_op = bin_op;
        private readonly string _right_field = right_field;

        public override string ToString()
        {
            _full = "ON ";
            _full += _left_field + " " + _bin_op + " " + _right_field;
            return _full;
        }
    }
}
