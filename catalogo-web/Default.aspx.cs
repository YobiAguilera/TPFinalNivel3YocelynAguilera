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
    public partial class Default : System.Web.UI.Page
    { 
        public List<Articulos> ListaArticulos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            ArticulosNegocio negocio = new ArticulosNegocio();
            ListaArticulos = negocio.listarConSP();

            if (!IsPostBack)
            {
                repRepetidor.DataSource = ListaArticulos;
                repRepetidor.DataBind();
            }
        }

        //protected void btnEjemplo_Click(object sender, EventArgs e)
        //{
        //    string valor = ((Button)sender).CommandArgument;
        //}
    }
}