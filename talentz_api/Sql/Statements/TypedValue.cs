namespace talentz_api.Sql.Statements
{
    public class TypedValue<T>(string value) : SqlStatement
    {
        private readonly string _value = value;

        public override string ToString()
        {
            string newVal = "";
            switch (Type.GetTypeCode(typeof(T)))
            {
                case TypeCode.DateTime:
                case TypeCode.String:
                    newVal = "\"" + _value + "\"";
                    break;
                case TypeCode.Boolean:
                case TypeCode.Int32:
                    newVal = _value;
                    break;
                default:
                    break;
            };

            return newVal;
        }
    }
}
