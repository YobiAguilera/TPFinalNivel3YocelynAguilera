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
    public partial class Favoritos : System.Web.UI.Page
    {
        public List<Articulos> listaProductos { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Trainee user = Session["trainee"] as Trainee;
                if (user == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id) && int.TryParse(id, out int idArticulo))
                {
                    ArticuloFavoritoNegocio negocio = new ArticuloFavoritoNegocio();
                    ArticuloFavorito nuevo = new ArticuloFavorito
                    {
                        IdUser = user.Id,
                        IdArticulo = idArticulo
                    };

                    negocio.insertarFavorito(nuevo);
                }

                listaProductos = new List<Articulos>();
                ArticuloFavoritoNegocio negocioArticulo = new ArticuloFavoritoNegocio();
                List<int> idArticulosFav = negocioArticulo.listarFavoritos(user.Id);

                if (idArticulosFav.Count > 0)
                {
                    ArticulosNegocio favorito = new ArticulosNegocio();
                    listaProductos = favorito.listarArticuloConID(idArticulosFav);
                    repRepeater.DataSource = listaProductos;
                    repRepeater.DataBind();
                }
            }
        }

        protected void btnEliminarFav_Click(object sender, EventArgs e)
        {
            Trainee user = Session["trainee"] as Trainee;

            if (user == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int idArticulo = int.Parse(((Button)sender).CommandArgument);
            ArticuloFavoritoNegocio negocio = new ArticuloFavoritoNegocio();
            try
            {
                negocio.eliminarFavorito(idArticulo, user.Id);
            }
            catch (Exception ex)
            {
               
                throw;
            }
            finally
            {
                Response.Redirect("Favoritos.aspx", false);
            }
        }

    }
}
