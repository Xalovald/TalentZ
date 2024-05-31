using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using talentz_api;

namespace TalentzTests
{
    public static class BaseTest
    {
        public static void Setup()
        {
            Environment.SetEnvironmentVariable("DATABASE", "talentz_bdd");
            Environment.SetEnvironmentVariable("PASSWORD", "R3cRu73M3n!7");
            Environment.SetEnvironmentVariable("SERVER", "localhost");
            Environment.SetEnvironmentVariable("USER", "talentz_user");
        }
    }
}
