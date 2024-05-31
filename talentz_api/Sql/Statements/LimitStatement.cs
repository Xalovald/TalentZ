namespace talentz_api.Sql.Statements
{
    public class LimitStatement : SqlStatement
    {
        private readonly int _number;
        public LimitStatement(int number)
        {
            _number = number;
        }

        public override string ToString()
        {
            _full = "LIMIT ";
            _full += _number;
            return _full;
        }
    }
}
