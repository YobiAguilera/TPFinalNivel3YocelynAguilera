using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace catalogo_web
{
    public partial class DetalleArticulos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string articuloId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(articuloId))
                {
                    CargarDetallesArticulo(articuloId);
                }
            }
        }

        private void CargarDetallesArticulo(string id)
        {
            ArticulosNegocio negocio = new ArticulosNegocio();
            Articulos articulo = negocio.listar(id).FirstOrDefault();
            if (articulo != null)
            {
                lblCodigo.Text = articulo.Codigo;
                lblNombre.Text = articulo.Nombre;
                lblDescripcion.Text = articulo.Descripcion;
                lblMarca.Text = articulo.Marca.Descripcion;
                lblCategoria.Text = articulo.Categoria.Descripcion;
                lblPrecio.Text = articulo.Precio.ToString("C");
                imgArticulo.ImageUrl = articulo.ImagenUrl;
            }
        }
        protected void btnAgregarFavoritos_Click(object sender, EventArgs e)
        {
            Trainee user = Session["trainee"] as Trainee;

            if (user == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string articuloId = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(articuloId) && int.TryParse(articuloId, out int idArticulo))
            {
                ArticuloFavoritoNegocio negocio = new ArticuloFavoritoNegocio();
                ArticuloFavorito nuevo = new ArticuloFavorito
                {
                    IdUser = user.Id,
                    IdArticulo = idArticulo
                };

                negocio.insertarFavorito(nuevo);
            }
            Response.Redirect("Favoritos.aspx");
        }

    }
}