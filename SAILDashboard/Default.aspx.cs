using System;
using System.Web.UI;

namespace SAILDashboard
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}