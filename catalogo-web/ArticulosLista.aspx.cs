using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace catalogo_web
{
    public partial class ArticulosLista : System.Web.UI.Page
    {
        public bool FiltroAvanzado { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["trainee"]))
            {
                Session.Add("Error", "Se requiere permiso del administrador para ingresar a esta página");
                Response.Redirect("Error.aspx");
            }

            FiltroAvanzado = cbxAvanzado.Checked;

            try
            {
                if (!IsPostBack)
                {
                    ArticulosNegocio negocio = new ArticulosNegocio();
                    Session.Add("ArticulosLista", negocio.listarConSP());
                    dgvArticulos.DataSource = Session["ArticulosLista"];
                    dgvArticulos.DataBind();
                }

            }
            catch (Exception ex)
            {
                Session.Add("Error", "Hubo un problema al cargar la página");
                Session.Add("Error", ex.Message);
                Response.Redirect("Error.aspx", false);
            }

        }

        protected void dgvArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvArticulos.SelectedDataKey.Value.ToString();
            Response.Redirect("ArticuloFormulario.aspx?id=" + id);
        }

        protected void dgvArticulos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                dgvArticulos.DataSource = Session["ArticulosLista"];
                dgvArticulos.PageIndex = e.NewPageIndex;
                dgvArticulos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", "Hubo un problema al cargar la página");
                Session.Add("Error", ex.Message);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void filtro_TextChanged(object sender, EventArgs e)
        {
            List<Articulos> lista = (List<Articulos>)Session["ArticulosLista"];
            List<Articulos> listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().Contains(tbxFiltro.Text.ToUpper()));
            dgvArticulos.DataSource = listaFiltrada;
            dgvArticulos.DataBind();
        }

        protected void cbxAvanzado_CheckedChanged(object sender, EventArgs e)
        {
            FiltroAvanzado = cbxAvanzado.Checked;
            tbxFiltro.Enabled = !FiltroAvanzado;
        }

        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCampo.SelectedItem.ToString() == "Precio")
            {
                ddlCriterio.Items.Clear();
                ddlCriterio.Items.Add("Igual a");
                ddlCriterio.Items.Add("Mayor a");
                ddlCriterio.Items.Add("Menor a");
            }
            else
            {
                ddlCriterio.Items.Clear();
                ddlCriterio.Items.Add("Contiene");
                ddlCriterio.Items.Add("Comienza con");
                ddlCriterio.Items.Add("Termina con");
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                ArticulosNegocio negocio = new ArticulosNegocio();
                dgvArticulos.DataSource = negocio.filtrar(ddlCampo.SelectedItem.ToString(), ddlCriterio.SelectedItem.ToString(), tbxFiltroAvanzado.Text);
                dgvArticulos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }
        protected void btnLimpiarFiltro_Click(object sender, EventArgs e)
        {
            tbxFiltro.Text = "";
            tbxFiltroAvanzado.Text = "";

            dgvArticulos.DataSource = Session["ArticulosLista"];
            dgvArticulos.DataBind();
        }

    }
}