using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace catalogo_web
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Trainee trainee = new Trainee();
            TraineeNegocio negocio = new TraineeNegocio();
            try
            {
                if (Validaciones.validaTextoVacio(tbxEmail) || Validaciones.validaTextoVacio(tbxPassword)) 
                {
                    Session.Add("Error", "Debes completar todos los campos.");
                    Response.Redirect("Error.aspx");
                }

                trainee.Email = tbxEmail.Text.Trim();
                trainee.Pass = tbxPassword.Text.Trim();

                if (negocio.Login(trainee))
                {
                    Session.Add("trainee", trainee);
                    Response.Redirect("MiPerfil.aspx", false);
                }
                else
                {
                    Session.Add("Error", "Usuario o contraseña ingresados incorrectos");
                    Response.Redirect("Error.aspx", false);
                }

            }
            catch(System.Threading.ThreadAbortException ex)
            {

            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }
        private void Page_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError();

            Session.Add("Error", exc.ToString());
            Server.Transfer("Error.aspx");
        }
    }
}