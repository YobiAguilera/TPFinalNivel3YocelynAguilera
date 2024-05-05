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
    public partial class MiPerfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Seguridad.sesionActiva(Session["trainee"]))
                    {
                        Trainee user = (Trainee)Session["trainee"];
                        tbxEmail.Text = user.Email;
                        tbxEmail.Enabled = false;
                        tbxNombre.Text = user.Nombre;
                        tbxApellido.Text = user.Apellido;
                        if (user.FechaNacimiento != null && user.FechaNacimiento != DateTime.MinValue)
                        {
                            tbxFechaNacimiento.Text = user.FechaNacimiento.ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            tbxFechaNacimiento.Text = string.Empty;
                        }
                        if (!string.IsNullOrEmpty(user.UrlImagenPerfil))
                            imgNuevoPerfil.ImageUrl = "~/Images/" + user.UrlImagenPerfil;
                    }
                }
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Page.Validate();
                if (!Page.IsValid)
                {
                    return;
                }

                TraineeNegocio negocio = new TraineeNegocio();
                Trainee user = (Trainee)Session["trainee"];

                if (tbxImagen.PostedFile.FileName != "")
                {
                    string ruta = Server.MapPath("./Images/");
                    string nombreArchivo = "perfil-" + user.Id + ".jpg";
                    tbxImagen.PostedFile.SaveAs(ruta + nombreArchivo);
                    user.UrlImagenPerfil = nombreArchivo;

                    imgNuevoPerfil.ImageUrl = "~/Images/" + nombreArchivo + "?v=" + DateTime.Now.Ticks.ToString();
                }

                user.Nombre = tbxNombre.Text;
                user.Apellido = tbxApellido.Text;
                if (DateTime.TryParse(tbxFechaNacimiento.Text, out DateTime fechaNacimiento))
                    user.FechaNacimiento = fechaNacimiento;

                negocio.actualizar(user);

                if (Master.FindControl("imgAvatar") is Image img)
                {
                    img.ImageUrl = "~/Images/" + user.UrlImagenPerfil + "?v=" + DateTime.Now.Ticks.ToString();
                }
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }

    }
}