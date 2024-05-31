using Microsoft.IdentityModel.Tokens;

namespace talentz_api.Sql.Statements
{
    public class UpdateStatement(string table, List<string> values) : SqlStatement
    {
        private readonly string _table = table;
        private readonly List<string> _values = values;

        public override string ToString()
        {
            _full = "UPDATE ";

            _full += _table + " ";

            _full += string.Join(',', _values.Where(a => !a.IsNullOrEmpty()).ToArray()).Replace(",SET", ",");

            return _full;
        }
    }
}
