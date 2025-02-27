using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using talentz_api.Sql;

namespace talentz_api.Controllers
{
    public abstract class GeneralController : ControllerBase
    {
        protected readonly static SqlConn mySqlClass = new(
            database: Environment.GetEnvironmentVariable("DATABASE"),
            uid: Environment.GetEnvironmentVariable("USER"),
            pwd: Environment.GetEnvironmentVariable("PASSWORD")
        );
        public readonly MySqlConnection conn = mySqlClass.GetConn();
    }
}
