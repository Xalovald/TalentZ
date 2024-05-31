using Microsoft.AspNetCore.Mvc.Infrastructure;
using System.Text.Json.Serialization;
using talentz_api.Helpers;
// Builder

string root = Directory.GetCurrentDirectory();
string dotenv = Path.Combine(root, ".env");
DotEnv.Load(dotenv);

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull;
});


builder.Configuration
    .SetBasePath(root)
    .AddJsonFile("appsettings.json", true)
    .AddEnvironmentVariables()
    .Build();

builder.Services.AddRouting();

builder.Services.AddAuthorization();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

app.Run();
