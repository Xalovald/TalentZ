using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using talentz_api.Controllers;
using talentz_api.Helpers;
using talentz_api.Models;

namespace talentz_api.Accessing
{
    [AttributeUsage(AttributeTargets.All)]
    public class AdminAccessAttribute : Attribute, IActionFilter
    {

        public void OnActionExecuting(ActionExecutingContext context)
        {
            UserController controller = new();
            if (!context.ActionArguments.Any(p => p.Key == "userId"))
            {
                context.Result = new BadRequestObjectResult(new
                {
                    Type = RfcLinks.BadRequest,
                    Title = "Bad Request",
                    Status = StatusCodes.Status400BadRequest,
                    TraceId = Guid.NewGuid(),
                    Message = "You have to be an administrator.",
                });
            }

            else
            {
                User user = controller.GetOne((int)context.ActionArguments["userId"]!);
                if (user.Role != "admin" && user.Role != "superadmin")
                {
                    context.Result = new UnauthorizedObjectResult("Unauthorized");
                }
            }
        }

        public void OnActionExecuted(ActionExecutedContext context) { }
    }
}
