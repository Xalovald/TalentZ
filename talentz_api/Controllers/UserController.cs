using Microsoft.AspNetCore.Mvc;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using talentz_api.Accessing;
using talentz_api.DataRequests;
using talentz_api.Helpers;
using talentz_api.JsonData;
using talentz_api.Models;
using talentz_api.Sql;
using talentz_api.Sql.Statements;
using static talentz_api.Helpers.HelperMethods;

namespace talentz_api.Controllers
{
    [ApiController]
    [Produces("application/json")]
    [Consumes("application/json")]
    [Route("/api/users")]
    public class UserController : UserControllerBase
    {

        [HttpPost("login")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(void))]
        public IActionResult Login([FromBody] LoginData data)
        {
            if (data == null || !data.GetType().GetProperties().Any(p => p.GetValue(data) != null))
            {
                return BadRequest(new
                {
                    Type = RfcLinks.BadRequest,
                    Title = "Bad Request",
                    Status = StatusCodes.Status400BadRequest,
                    TraceId = Guid.NewGuid(),
                    Message = "No field provided for login.",
                });
            }

            List<SqlStatement> sqlStatements = [
                new SelectStatement("users", ["*"]),
                new WhereStatement(["users.email", "=", "@email", "AND", "users.password", "=", "md5(@password)"])
            ];

            SqlQuery sqlQuery = new(conn, sqlStatements, "users", [
                new PreparedParameter("@email", data.Email),
                new PreparedParameter("@password", data.Password)

            ]);

            sqlQuery.ExecuteGet();

            if (sqlQuery.GetTable().Rows.Count <= 0)
            {
                return Unauthorized(new
                {
                    Type = RfcLinks.Unauthorized,
                    Title = "Unauthorized",
                    Status = StatusCodes.Status401Unauthorized,
                    TraceId = Guid.NewGuid(),
                    Message = "Wrong credentials.",
                });
            }
            return Ok();
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<User>))]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public List<User> GetAll()
        {
            List<SqlStatement> queryStatementUsers = [
                new SelectStatement("users", ["*"]),
                new WhereStatement(["users.role", new InStatement([
                        new TypedValue<string>("candidat").ToString(),
                        new TypedValue<string>("entreprise").ToString()
                    ]).ToString()
                ])
            ];
            SqlQuery sqlQueryUsers = new(conn, queryStatementUsers, "users");
            sqlQueryUsers.ExecuteGet();

            List<User> dataUser = [];

            foreach (DataRow row in sqlQueryUsers.GetTable().Rows)
            {

                List<Apprentissage> dataApprentissages = GetTableFromInvIdx<Apprentissage>(row, "invidx_apprentissages", "apprentissages");
                List<Avantage> dataAvantages = GetTableFromInvIdx<Avantage>(row, "invidx_avantages", "avantages");
                List<Carriere> dataCarrieres = GetTableFromInvIdx<Carriere>(row, "invidx_carrieres", "carrieres");
                List<Competence> dataCompetences = GetTableFromInvIdx<Competence>(row, "invidx_competences", "competences");
                List<Mission> dataMissions = GetTableFromInvIdx<Mission>(row, "invidx_missions", "missions");
                List<Personnalite> dataPersonnalites = GetTableFromInvIdx<Personnalite>(row, "invidx_personnalites", "personnalites");
                List<ValeurEthique> dataValeursEthiques = GetTableFromInvIdx<ValeurEthique>(row, "invidx_valeurs_ethiques", "valeurs_ethiques");
                List<string> validRoles = ["candidat", "admin", "superadmin"];
                dataUser.Add(new User()
                {
                    Id = (int)row["id"],
                    LastName = ShowIfRoles(validRoles, (string)row["role"], (string)row["nom"]),
                    FirstName = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["prenom"])),
                    CompanyName = ShowIfRoles(["entreprise"], (string)row["role"], (string)row["nom"]),
                    DateNaissance = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<DateTime>(row["date_naissance"])),
                    Cerise = (int)row["cerise"],
                    WhyCerise = (string)row["why_cerise"],
                    Telephone = (string)row["telephone"],
                    Email = (string)row["email"],
                    City = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["ville"])!),
                    Address = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["adresse"])!),
                    Siret = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["siret"])),
                    Location = ShowIfRoles(["entreprise"], (string)row["role"], ConvertFromDBVal<string>(row["location"])!),
                    Role = (string)row["role"],
                    Apprentissages = dataApprentissages,
                    Avantages = dataAvantages,
                    Carrieres = dataCarrieres,
                    Competences = dataCompetences,
                    Missions = dataMissions,
                    Personnalites = dataPersonnalites,
                    ValeursEthiques = dataValeursEthiques,
                });
            };


            return dataUser;
        }

        [AdminAccess]
        [HttpGet("elevated")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<User>))]
        public List<User> GetElevated([FromQuery] int userId)
        {
            List<SqlStatement> queryStatementUsers = [
                new SelectStatement("users", ["*"]),
                new WhereStatement(["users.role", new InStatement([
                        new TypedValue<string>("admin").ToString()
                    ]).ToString()
                ])
            ];
            SqlQuery sqlQueryUsers = new(conn, queryStatementUsers, "users");
            sqlQueryUsers.ExecuteGet();

            List<User> dataUser = [];

            foreach (DataRow row in sqlQueryUsers.GetTable().Rows)
            {
                List<Apprentissage> dataApprentissages = GetTableFromInvIdx<Apprentissage>(row, "invidx_apprentissages", "apprentissages");
                List<Avantage> dataAvantages = GetTableFromInvIdx<Avantage>(row, "invidx_avantages", "avantages");
                List<Carriere> dataCarrieres = GetTableFromInvIdx<Carriere>(row, "invidx_carrieres", "carrieres");
                List<Competence> dataCompetences = GetTableFromInvIdx<Competence>(row, "invidx_competences", "competences");
                List<Mission> dataMissions = GetTableFromInvIdx<Mission>(row, "invidx_missions", "missions");
                List<Personnalite> dataPersonnalites = GetTableFromInvIdx<Personnalite>(row, "invidx_personnalites", "personnalites");
                List<ValeurEthique> dataValeursEthiques = GetTableFromInvIdx<ValeurEthique>(row, "invidx_valeurs_ethiques", "valeurs_ethiques");

                List<string> validRoles = ["candidat", "admin", "superadmin"];
                dataUser.Add(new User()
                {
                    Id = (int)row["id"],
                    LastName = ShowIfRoles(validRoles, (string)row["role"], (string)row["nom"]),
                    FirstName = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["prenom"])),
                    CompanyName = ShowIfRoles(["entreprise"], (string)row["role"], (string)row["nom"]),
                    DateNaissance = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<DateTime>(row["date_naissance"])),
                    Cerise = ShowIfRoles(validRoles, (string)row["role"], (int)row["cerise"]),
                    WhyCerise = ShowIfRoles(validRoles, (string)row["role"], (string)row["why_cerise"]),
                    Telephone = (string)row["telephone"],
                    Email = (string)row["email"],
                    City = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["ville"])!),
                    Address = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["adresse"])!),
                    Siret = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["siret"])),
                    Location = ShowIfRoles(["entreprise"], (string)row["role"], ConvertFromDBVal<string>(row["location"])!),
                    Role = (string)row["role"],
                    Apprentissages = dataApprentissages,
                    Avantages = dataAvantages,
                    Carrieres = dataCarrieres,
                    Competences = dataCompetences,
                    Missions = dataMissions,
                    Personnalites = dataPersonnalites,
                    ValeursEthiques = dataValeursEthiques,
                });
            }

            return dataUser;
        }

        [HttpGet("{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(User))]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public User? GetOne(int userId)
        {
            SqlQuery sqlQueryUsers = CustomQueries.QueryOneUser(userId, conn);

            User? dataUser = null;

            foreach (DataRow row in sqlQueryUsers.GetTable().Rows)
            {
                List<Apprentissage> dataApprentissages = GetTableFromInvIdx<Apprentissage>(row, "invidx_apprentissages", "apprentissages");
                List<Avantage> dataAvantages = GetTableFromInvIdx<Avantage>(row, "invidx_avantages", "avantages");
                List<Carriere> dataCarrieres = GetTableFromInvIdx<Carriere>(row, "invidx_carrieres", "carrieres");
                List<Competence> dataCompetences = GetTableFromInvIdx<Competence>(row, "invidx_competences", "competences");
                List<Mission> dataMissions = GetTableFromInvIdx<Mission>(row, "invidx_missions", "missions");
                List<Personnalite> dataPersonnalites = GetTableFromInvIdx<Personnalite>(row, "invidx_personnalites", "personnalites");
                List<ValeurEthique> dataValeursEthiques = GetTableFromInvIdx<ValeurEthique>(row, "invidx_valeurs_ethiques", "valeurs_ethiques");
                List<string> validRoles = ["candidat", "admin", "superadmin"];
                dataUser = new User()
                {
                    Id = (int)row["id"],
                    LastName = ShowIfRoles(validRoles, (string)row["role"], (string)row["nom"]),
                    FirstName = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["prenom"])),
                    CompanyName = ShowIfRoles(["entreprise"], (string)row["role"], (string)row["nom"]),
                    DateNaissance = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<DateTime>(row["date_naissance"])),
                    Cerise = ShowIfRoles(validRoles, (string)row["role"], (int)row["cerise"]),
                    WhyCerise = ShowIfRoles(validRoles, (string)row["role"], (string)row["why_cerise"]),
                    Telephone = (string)row["telephone"],
                    Email = (string)row["email"],
                    City = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["ville"])!),
                    Address = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["adresse"])!),
                    Siret = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["siret"])),
                    Location = ShowIfRoles(["entreprise"], (string)row["role"], ConvertFromDBVal<string>(row["location"])!),
                    Role = (string)row["role"],
                    Apprentissages = dataApprentissages,
                    Avantages = dataAvantages,
                    Carrieres = dataCarrieres,
                    Competences = dataCompetences,
                    Missions = dataMissions,
                    Personnalites = dataPersonnalites,
                    ValeursEthiques = dataValeursEthiques,
                };
            }
            return dataUser;
        }

        [HttpPost("candidats")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(void))]
        public void CreateCandidatUser([FromBody] UserCandidatData data, bool execute = true)
        {
            List<SqlStatement> sqlStatements = [
                new InsertStatement("users", ["nom", "prenom", "date_naissance", "telephone", "email", "ville", "adresse", "role", "password", "cerise", "why_cerise"]),
                new ValuesStatement([
                    "@lastName",
                    "@firstName",
                    "@dateNaissance",
                    "@telephone",
                    "@email",
                    "@city",
                    "@address",
                    new TypedValue<string>("candidat").ToString(),
                    "md5(@password)",
                    "@cerise",
                    "@whyCerise"
                ])
            ];


            SqlQuery sqlQuery = new(conn, sqlStatements, "users", [
                new PreparedParameter("@lastName", data.LastName),
                new PreparedParameter("@firstName", data.FirstName),
                new PreparedParameter("@dateNaissance", data.DateNaissance),
                new PreparedParameter("@telephone", data.Telephone),
                new PreparedParameter("@email", data.Email),
                new PreparedParameter("@city", data.City),
                new PreparedParameter("address", data.Address),
                new PreparedParameter("@password", data.Password),
                new PreparedParameter("@cerise", data.Cerise),
                new PreparedParameter("@whyCerise", data.WhyCerise),
            ]);

            if(execute) sqlQuery.ExecuteNonQuery();

            InsertInInvIdx("invidx_apprentissages", execute, data.Apprentissages);
            InsertInInvIdx("invidx_avantages", execute, data.Avantages);
            InsertInInvIdx("invidx_carrieres", execute, data.Carrieres);
            InsertInInvIdx("invidx_competences", execute, data.Competences);
            InsertInInvIdx("invidx_missions", execute, data.Missions);
            InsertInInvIdx("invidx_personnalites", execute, data.Personnalites);
            InsertInInvIdx("invidx_valeurs_ethiques", execute, data.ValeursEthiques);


            Response.StatusCode = StatusCodes.Status201Created;
            Response.Headers.Location = $"http://localhost:5212/api/users/{GetIds().Last() + 1}";
        }

        //Get candidat
        [HttpGet("candidats")]
        public List<User> GetCandidats()
        {
            SqlQuery sqlQueryUsers = CustomQueries.QueryRoleUser("candidat", conn);

            List<User> dataUser = [];

            foreach (DataRow row in sqlQueryUsers.GetTable().Rows)
            {
                List<Apprentissage> dataApprentissages = GetTableFromInvIdx<Apprentissage>(row, "invidx_apprentissages", "apprentissages");
                List<Avantage> dataAvantages = GetTableFromInvIdx<Avantage>(row, "invidx_avantages", "avantages");
                List<Carriere> dataCarrieres = GetTableFromInvIdx<Carriere>(row, "invidx_carrieres", "carrieres");
                List<Competence> dataCompetences = GetTableFromInvIdx<Competence>(row, "invidx_competences", "competences");
                List<Mission> dataMissions = GetTableFromInvIdx<Mission>(row, "invidx_missions", "missions");
                List<Personnalite> dataPersonnalites = GetTableFromInvIdx<Personnalite>(row, "invidx_personnalites", "personnalites");
                List<ValeurEthique> dataValeursEthiques = GetTableFromInvIdx<ValeurEthique>(row, "invidx_valeurs_ethiques", "valeurs_ethiques");
                List<string> validRoles = ["candidat", "admin", "superadmin"];
                dataUser.Add(new User()
                {
                    Id = (int)row["id"],
                    LastName = ShowIfRoles(validRoles, (string)row["role"], (string)row["nom"]),
                    FirstName = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["prenom"])),
                    CompanyName = ShowIfRoles(["entreprise"], (string)row["role"], (string)row["nom"]),
                    DateNaissance = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<DateTime>(row["date_naissance"])),
                    Cerise = ShowIfRoles(validRoles, (string)row["role"], (int)row["cerise"]),
                    WhyCerise = ShowIfRoles(validRoles, (string)row["role"], (string)row["why_cerise"]),
                    Telephone = (string)row["telephone"],
                    Email = (string)row["email"],
                    City = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["ville"])!),
                    Address = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["adresse"])!),
                    Siret = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["siret"])),
                    Location = ShowIfRoles(["entreprise"], (string)row["role"], ConvertFromDBVal<string>(row["location"])!),
                    Role = (string)row["role"],
                    Apprentissages = dataApprentissages,
                    Avantages = dataAvantages,
                    Carrieres = dataCarrieres,
                    Competences = dataCompetences,
                    Missions = dataMissions,
                    Personnalites = dataPersonnalites,
                    ValeursEthiques = dataValeursEthiques,
                });
            }
            return dataUser;
        }

        [HttpPost("entreprises")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(User))]
        public void CreateEntrepriseUser([FromBody] UserEntrepriseData data, bool execute = true)
        {
            List<SqlStatement> sqlStatements = [
                new InsertStatement("users", ["nom", "telephone", "email", "siret", "location", "password", "role", "cerise", "why_cerise"]),
                new ValuesStatement([
                    "@companyName",
                    "@telephone",
                    "@email",
                    "@siret",
                    "@location",
                    "md5(@password)",
                    new TypedValue<string>("entreprise").ToString(),
                    "@cerise",
                    "@whyCerise"
                ])

            ];

            SqlQuery sqlQuery = new(conn, sqlStatements, "users", [
                new PreparedParameter("@companyName", data.CompanyName),
                new PreparedParameter("@telephone", data.Telephone),
                new PreparedParameter("@email", data.Email),
                new PreparedParameter("@location", data.Location),
                new PreparedParameter("@siret", data.Siret),
                new PreparedParameter("@password", data.Password),
                new PreparedParameter("@cerise", data.Cerise),
                new PreparedParameter("@whyCerise", data.WhyCerise),
            ]); ;

            if (execute) sqlQuery.ExecuteNonQuery();

            InsertInInvIdx("invidx_apprentissages", execute, data.Apprentissages);
            InsertInInvIdx("invidx_avantages", execute, data.Avantages);
            InsertInInvIdx("invidx_carrieres", execute, data.Carrieres);
            InsertInInvIdx("invidx_competences", execute, data.Competences);
            InsertInInvIdx("invidx_missions", execute, data.Missions);
            InsertInInvIdx("invidx_personnalites", execute, data.Personnalites);
            InsertInInvIdx("invidx_valeurs_ethiques", execute, data.ValeursEthiques);

            Response.StatusCode = StatusCodes.Status201Created;
            Response.Headers.Location = $"http://localhost:5212/api/users/{GetIds().Last() + 1}";
        }

        //Get entreprise
        [HttpGet("entreprises")]
        public List<User> GetEntreprises()
        {
            SqlQuery sqlQueryUsers = CustomQueries.QueryRoleUser("entreprise", conn);

            List<User> dataUser = [];

            foreach (DataRow row in sqlQueryUsers.GetTable().Rows)
            {
                List<Apprentissage> dataApprentissages = GetTableFromInvIdx<Apprentissage>(row, "invidx_apprentissages", "apprentissages");
                List<Avantage> dataAvantages = GetTableFromInvIdx<Avantage>(row, "invidx_avantages", "avantages");
                List<Carriere> dataCarrieres = GetTableFromInvIdx<Carriere>(row, "invidx_carrieres", "carrieres");
                List<Competence> dataCompetences = GetTableFromInvIdx<Competence>(row, "invidx_competences", "competences");
                List<Mission> dataMissions = GetTableFromInvIdx<Mission>(row, "invidx_missions", "missions");
                List<Personnalite> dataPersonnalites = GetTableFromInvIdx<Personnalite>(row, "invidx_personnalites", "personnalites");
                List<ValeurEthique> dataValeursEthiques = GetTableFromInvIdx<ValeurEthique>(row, "invidx_valeurs_ethiques", "valeurs_ethiques");
                List<string> validRoles = ["entreprise", "admin", "superadmin"];
                dataUser.Add(new User()
                {
                    Id = (int)row["id"],
                    LastName = ShowIfRoles(validRoles, (string)row["role"], (string)row["nom"]),
                    FirstName = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["prenom"])),
                    CompanyName = ShowIfRoles(["entreprise"], (string)row["role"], (string)row["nom"]),
                    DateNaissance = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<DateTime>(row["date_naissance"])),
                    Cerise = ShowIfRoles(validRoles, (string)row["role"], (int)row["cerise"]),
                    WhyCerise = ShowIfRoles(validRoles, (string)row["role"], (string)row["why_cerise"]),
                    Telephone = (string)row["telephone"],
                    Email = (string)row["email"],
                    City = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["ville"])!),
                    Address = ShowIfRoles(validRoles, (string)row["role"], ConvertFromDBVal<string>(row["adresse"])!),
                    Siret = NotDefaultOrNull<string>(ConvertFromDBVal<string>(row["siret"])),
                    Location = ShowIfRoles(["entreprise"], (string)row["role"], ConvertFromDBVal<string>(row["location"])!),
                    Role = (string)row["role"],
                    Apprentissages = dataApprentissages,
                    Avantages = dataAvantages,
                    Carrieres = dataCarrieres,
                    Competences = dataCompetences,
                    Missions = dataMissions,
                    Personnalites = dataPersonnalites,
                    ValeursEthiques = dataValeursEthiques,
                });
            }
            return dataUser;
        }

        [HttpPatch("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult PatchUser(int Id, [FromBody] User data, bool execute = true)
        {
            if (data == null || !data.GetType().GetProperties().Any(p => p.GetValue(data) != null))
            {
                return BadRequest(new
                {
                    Type = RfcLinks.BadRequest,
                    Title = "Bad Request",
                    Status = StatusCodes.Status400BadRequest,
                    TraceId = Guid.NewGuid(),
                    Message = "No field provided for update.",
                });
            }
            List<SqlStatement> sqlStatements = [
                new UpdateStatement("users", [
                    data.LastName != null ? new SetStatement("nom", "@lastName").ToString() : "",
                    data.FirstName != null ? new SetStatement("prenom","@firstName").ToString() : "",
                    data.CompanyName != null ? new SetStatement("nom", "@companyName").ToString() : "",
                    data.DateNaissance != null ? new SetStatement("date_naissance","@dateNaissance").ToString() : "",
                    data.Telephone != null ? new SetStatement("telephone","@telephone").ToString() : "",
                    data.Email != null ? new SetStatement("email","@email").ToString() : "",
                    data.Siret != null ? new SetStatement("siret","@siret").ToString() : ""
                ] ),
                new WhereStatement(["users.id", "=", "@userId"])
            ];

            SqlQuery query = new(conn, sqlStatements, "userPatch", [
                new PreparedParameter("@lastName", data.LastName ?? ""),
                new PreparedParameter("@firtsName", data.FirstName ?? ""),
                new PreparedParameter("@companyName", data.CompanyName ?? ""),
                new PreparedParameter("@dateNaissance", NotDefaultOrEmptyString<DateTime>(ConvertFromDBVal<DateTime>(data.DateNaissance!))),
                new PreparedParameter("@telephone", data.Telephone ?? ""),
                new PreparedParameter("@email", data.Email ?? ""),
                new PreparedParameter("@siret", data.Siret ?? ""),
                new PreparedParameter("@userId",Id),
            ]);
            
            int rowsAffected = 0;

            if(execute)
            {
                rowsAffected = query.ExecuteNonQuery();
            }

            if (rowsAffected == 0 && !GetIds().Contains(Id))
            {
                return NotFound(new
                {
                    Type = RfcLinks.NotFound,
                    Title = "Not Found",
                    Status = StatusCodes.Status404NotFound,
                    TraceId = Guid.NewGuid(),
                    Message = "No Id provided.",
                });
            }

            return NoContent();
        }

        [AdminAccess]
        [HttpDelete("{Id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent, Type = typeof(IActionResult))]
        [ProducesResponseType(StatusCodes.Status404NotFound, Type = typeof(IActionResult))]
        public IActionResult DeleteUser([FromQuery] int? userId, int Id, bool execute = true)
        {
            List<SqlStatement> sqlStatements = [
                new DeleteStatement("users", []),
                new WhereStatement(["users.id", "=", "@idDelete"])
            ];

            SqlQuery query = new(conn, sqlStatements, "userDelete", [
                new PreparedParameter("@idDelete", Id)
            ]);

            if (execute)
            {
                int rowsAffected = query.ExecuteNonQuery();

                if (rowsAffected == 0)
                {
                    return NotFound(new
                    {
                        Type = RfcLinks.NotFound,
                        Title = "Not Found",
                        Status = StatusCodes.Status404NotFound,
                        TraceId = Guid.NewGuid(),
                        Message = "User not found.",
                    });
                };
            }

            return NoContent();
        }
    }
}