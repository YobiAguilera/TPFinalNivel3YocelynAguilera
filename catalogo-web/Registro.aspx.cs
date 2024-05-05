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
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {
            try
            {
                Trainee user = new Trainee();
                TraineeNegocio traineeNegocio = new TraineeNegocio();
                EmailService emailService = new EmailService();

                user.Email = tbxEmail.Text;
                user.Pass = tbxPassword.Text;
                user.Id = traineeNegocio.insertarNuevo(user);
                Session.Add("trainee", user);

                emailService.armarCorreo(user.Email, "Bienvenida Trainee", "¡Hola, te damos la bienvenida a la app!");
                emailService.enviarEmail();
                Response.Redirect("Default.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }
    }
}