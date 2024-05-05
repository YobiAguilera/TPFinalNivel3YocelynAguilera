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
    public partial class ArticuloFormulario : System.Web.UI.Page
    {
        public bool ConfirmarEliminacion { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            tbxId.Enabled = false;
            ConfirmarEliminacion = false;

            try
            {
                //Configuración inicial de la pantalla
                if (!IsPostBack)
                {
                    CategoriasNegocio categoriasnegocio = new CategoriasNegocio();
                    List<Categorias> listacategorias = categoriasnegocio.listar();

                    MarcasNegocio marcasnegocio = new MarcasNegocio();
                    List<Marcas> listamarcas = marcasnegocio.listar();

                    ddlCategoria.DataSource = listacategorias;
                    ddlCategoria.DataValueField = "Id";
                    ddlCategoria.DataTextField = "Descripcion";
                    ddlCategoria.DataBind();

                    ddlMarca.DataSource = listamarcas;
                    ddlMarca.DataValueField = "Id";
                    ddlMarca.DataTextField = "Descripcion";
                    ddlMarca.DataBind();
                }

                //Configuración si estamos modificando
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "" && !IsPostBack)
                {
                    ArticulosNegocio negocio = new ArticulosNegocio();
                    //List<Articulos> lista = negocio.listar(id);
                    //Articulos seleccionado = lista[0];
                    Articulos seleccionado = (negocio.listar(id))[0]; // lo mismo de arriba pero en una sola linea.

                    // Precargar todos los campos
                    tbxId.Text = id;
                    tbxCodigo.Text = seleccionado.Codigo;
                    tbxNombre.Text = seleccionado.Nombre;
                    tbxDescripcion.Text = seleccionado.Descripcion;
                    tbxImagenUrl.Text = seleccionado.ImagenUrl;
                    tbxPrecio.Text = seleccionado.Precio.ToString();

                    ddlMarca.SelectedValue = seleccionado.Marca.Id.ToString();
                    ddlCategoria.SelectedValue = seleccionado.Categoria.Id.ToString();

                    tbxImagenUrl_TextChanged(sender, e);
                }

            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                Page.Validate();
                if (!Page.IsValid)
                {
                    return;
                }

                Articulos nuevo = new Articulos();
                ArticulosNegocio negocio = new ArticulosNegocio();

                nuevo.Codigo = tbxCodigo.Text;
                nuevo.Nombre = tbxNombre.Text;
                nuevo.Descripcion = tbxDescripcion.Text;
                nuevo.Precio = decimal.Parse(tbxPrecio.Text);
                nuevo.ImagenUrl = tbxImagenUrl.Text;

                nuevo.Marca = new Marcas();
                nuevo.Marca.Id = int.Parse(ddlMarca.SelectedValue);
                nuevo.Categoria = new Categorias();
                nuevo.Categoria.Id = int.Parse(ddlCategoria.SelectedValue);

                if (Request.QueryString["id"] != null)
                {
                    nuevo.Id = int.Parse(tbxId.Text);
                    negocio.modificarConSP(nuevo);
                }
                else
                    negocio.agregarConSP(nuevo);


                Response.Redirect("ArticulosLista.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }

        protected void tbxImagenUrl_TextChanged(object sender, EventArgs e)
        {
            imgArticulo.ImageUrl = tbxImagenUrl.Text;
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            ConfirmarEliminacion = true;
        }

        protected void btnConfirmarEliminacion_Click(object sender, EventArgs e)
        {
            try
            {
                if (cbxConfirmarEliminacion.Checked)
                {
                    ArticulosNegocio negocio = new ArticulosNegocio();
                    negocio.eliminar(int.Parse(tbxId.Text));
                    Response.Redirect("ArticulosLista.aspx");
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