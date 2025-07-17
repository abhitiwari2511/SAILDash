using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace SAILDashboard
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            // Add default route to Dashboard
            routes.MapPageRoute(
                "DefaultRoute",
                "",
                "~/Dashboard.aspx"
            );

            // Add explicit dashboard route
            routes.MapPageRoute(
                "Dashboard",
                "dashboard",
                "~/Dashboard.aspx"
            );

            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);
        }
    }
}
