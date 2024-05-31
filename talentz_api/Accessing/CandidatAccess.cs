using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using talentz_api.Controllers;
using talentz_api.Models;

namespace talentz_api.Accessing
{
    [AttributeUsage(AttributeTargets.All)]
    public class CandidatAccessAttribute : Attribute, IActionFilter
    {

        public void OnActionExecuting(ActionExecutingContext context)
        {
            UserController controller = new();
            User user = controller.GetOne((int)context.ActionArguments["userId"]!);
            if (user.Role != "candidat" || user.Role != "moderateur" || user.Role != "admin" || user.Role != "superadmin")
            {
                context.Result = new UnauthorizedObjectResult("Unauthorized");
            }
        }

        public void OnActionExecuted(ActionExecutedContext context) { }
    }
}
