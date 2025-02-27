namespace talentz_api.Sql.Statements
{
    public class ValuesStatement(params List<string?>[] valuesArray) : SqlStatement
    {
        private readonly List<string>[] _valuesArray = valuesArray;

        public override string ToString()
        {
            _full = "VALUES ";

            foreach (var values in _valuesArray)
            {
                values.RemoveAll(e => e == null);
                _full += "(";

                _full += string.Join(',', values);

                _full += "),";
            }

            _full = _full.Remove(_full.LastIndexOf(','));

            return _full;
        }
    }
}
