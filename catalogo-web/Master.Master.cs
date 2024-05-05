using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace catalogo_web
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            imgAvatar.ImageUrl = "https://www.shutterstock.com/image-vector/profile-photo-vector-placeholder-pic-250nw-535853263.jpg";

            lblUser.Visible = false;
            imgAvatar.Visible = false;

            if (!(Page is Login || Page is Registro || Page is Default || Page is Error))
            {
                if (!Seguridad.sesionActiva(Session["trainee"]))
                    Response.Redirect("Login.aspx", false);
                else
                {
                    Trainee user = (Trainee)Session["trainee"];

                    lblUser.Text = "¡Hola, " + user.Nombre + "!";
                    lblUser.Visible = true; 

                    if (!string.IsNullOrEmpty(user.UrlImagenPerfil))
                    {
                        imgAvatar.ImageUrl = "~/Images/" + user.UrlImagenPerfil;
                        imgAvatar.Visible = true; 
                    }
                }
            }
        }
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}