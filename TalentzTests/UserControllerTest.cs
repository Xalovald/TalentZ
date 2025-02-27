using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using talentz_api.Controllers;
using talentz_api.JsonData;
using talentz_api.Models;
using System.Diagnostics;
using static TalentzTests.BaseTest;

namespace TalentzTests
{
    [TestClass]
    public class UserControllerTests
    {
        [TestMethod]
        public void GetAll()
        {
            Setup();

            UserController controller = new();
            dynamic result = controller.GetAll();

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType<List<User>>(result);
            Assert.IsTrue(result.Count > 0);
        }

        [TestMethod]
        public void GetOne()
        {
            Setup();

            UserController controller = new();
            dynamic result = controller.GetOne(1);

            User expected = new()
            {
                Id = 1,
                LastName = "Derepierre",
                FirstName = "Alexandre",
                CompanyName = null,
                DateNaissance = DateTime.Parse("2002-10-16T00:00:00"),
                Telephone = "0782681033",
                Email = "derepierre.alexandre@gmail.com",
                City = "Chambéry",
                Address = "route du pre joli",
                Siret = null,
                Location = null,
                Role = "admin",
                Qualites = [
                    new() { Id = 2, Nom = "Gentil" }
                ],
                Password = null
            };
            Assert.IsNotNull(result);
            Assert.IsInstanceOfType<User>(result);
            Assert.AreEqual(JsonConvert.SerializeObject(expected), JsonConvert.SerializeObject(result));
        }

        [TestMethod]
        public void CreateCandidat()
        {
            Setup();
            UserControllerBase controllerBase = new();
            UserCandidatData expected = new()
            {
                LastName = "Derepierre",
                FirstName = "Alexandre",
                DateNaissance = DateTime.Parse("2002-10-16T00:00:00"),
                Telephone = "0782681033",
                Email = "derepierre.alexandre@gmail.com",
                City = "Chambéry",
                Address = "route du pre joli",
                Password = "Crunchy's"
            };

            DefaultHttpContext httpContext = new();
            UserController controller = new()
            { 
                ControllerContext = new ControllerContext()
                {
                    HttpContext = httpContext
                }
            };

            controller.CreateCandidatUser(expected, false);
            
            Assert.AreEqual(201, httpContext.Response.StatusCode);
            Assert.IsTrue(httpContext.Response.Headers.ContainsKey("Location"));
            Assert.AreEqual($"http://localhost:5212/api/users/{controllerBase.GetIds().Last() + 1}", httpContext.Response.Headers.Location);
        }

        [TestMethod]
        public void CreateEntreprise()
        {
            Setup();
            UserControllerBase controllerBase = new();
            UserEntrepriseData expected = new()
            {
                CompanyName = "notreentrprise",
                Telephone = "0782681033",
                Email = "derepierre.alexandre@gmail.com",
                Siret = "1234567890",
                Location = "12 rue du chinchilla 74000 Annecy",
                Password = "Crunchy's"
            };

            DefaultHttpContext httpContext = new();
            UserController controller = new()
            {
                ControllerContext = new ControllerContext()
                {
                    HttpContext = httpContext
                }
            };

            controller.CreateEntrepriseUser(expected, false);

            Assert.AreEqual(201, httpContext.Response.StatusCode);
            Assert.IsTrue(httpContext.Response.Headers.ContainsKey("Location"));
            Assert.AreEqual($"http://localhost:5212/api/users/{controllerBase.GetIds().Last() + 1}", httpContext.Response.Headers.Location);
        }

        [TestMethod]
        public void PatchUser()
        {
            Setup();
            User expected = new()
            {
                Email = "derepierre.alexandre@gmail.com"
            };

            DefaultHttpContext httpContext = new();
            UserController controller = new()
            {
                ControllerContext = new ControllerContext()
                {
                    HttpContext = httpContext
                }
            };

            IActionResult result = controller.PatchUser(1, expected, false);
            Assert.IsInstanceOfType(result,typeof(NoContentResult));
        }

        [TestMethod]
        public void DeleteUser()
        {
            Setup();

            DefaultHttpContext httpContext = new();
            UserController controller = new()
            {
                ControllerContext = new ControllerContext()
                {
                    HttpContext = httpContext
                }
            };

            IActionResult result = controller.DeleteUser(1, 2, false);
            Assert.IsInstanceOfType(result, typeof(NoContentResult));
        }
    }
}