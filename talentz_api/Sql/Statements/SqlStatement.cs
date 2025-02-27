namespace talentz_api.Sql.Statements
{
    public abstract class SqlStatement
    {
        protected string _full = "";

        public override abstract string ToString();
    }
}
