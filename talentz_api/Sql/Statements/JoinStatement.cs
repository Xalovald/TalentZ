namespace talentz_api.Sql.Statements
{
    public class JoinStatement : SqlStatement
    {
        private readonly string _table_to;
        private readonly string _type = "";
        private readonly OnStatement _on_statement;
        public JoinStatement(string table_to, string type, OnStatement on_statement)
        {
            _table_to = table_to;
            _type = type;
            _on_statement = on_statement;
            CheckType();
        }

        private void CheckType()
        {
            _full = _type.ToLower() switch
            {
                "left" => "LEFT JOIN ",
                "right" => "RIGHT JOIN ",
                "inner" => "INNER JOIN ",
                _ => "JOIN ",
            };
        }

        public override string ToString()
        {
            _full += _table_to + " ";
            _full += _on_statement.ToString();
            return _full;
        }
    }
}
