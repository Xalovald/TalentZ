namespace talentz_api.Sql.Statements
{
    public class PreparedParameter(string parameter_name, dynamic value)
    {
        public readonly string parameterName = parameter_name;
        public readonly dynamic value = value;
    }
}
