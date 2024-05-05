using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using dominio;

namespace negocio
{
    public class ArticulosNegocio
    {
        public List<Articulos> listar(string id = "")
        {
            List<Articulos> lista = new List<Articulos>();
            SqlConnection conexion = new SqlConnection();
            SqlCommand comando = new SqlCommand();
            SqlDataReader lector;

            try
            {
                conexion.ConnectionString = "server=.\\SQLEXPRESS; database=CATALOGO_WEB_DB; integrated security=true";
                comando.CommandType = System.Data.CommandType.Text;
                comando.CommandText = "Select A.Codigo, A.Nombre, A.Descripcion, A.ImagenUrl, M.Descripcion as Marca, C. Descripcion as Categoria, A. Precio, A.IdMarca, A.IdCategoria, A.Id From ARTICULOS A, MARCAS M, CATEGORIAS C where M.Id = A.IdMarca and C. Id = A. IdCategoria ";
                if (id != "")
                    comando.CommandText += " and A.Id = " + id;
                comando.Connection = conexion;

                conexion.Open();
                lector = comando.ExecuteReader();

                while (lector.Read())
                {
                    Articulos aux = new Articulos();
                    aux.Id = (int)lector["Id"];
                    aux.Codigo = (string)lector["Codigo"];
                    aux.Nombre = (string)lector["Nombre"];
                    aux.Descripcion = (string)lector["Descripcion"];

                    if (!(lector["ImagenUrl"] is DBNull))
                        aux.ImagenUrl = (string)lector["ImagenUrl"];

                    aux.Marca = new Marcas();
                    aux.Marca.Id = (int)lector["IdMarca"];
                    aux.Marca.Descripcion = (string)lector["Marca"];
                    aux.Categoria = new Categorias();
                    aux.Categoria.Id = (int)lector["IdCategoria"];
                    aux.Categoria.Descripcion = (string)lector["Categoria"];
                    aux.Precio = Decimal.Round(lector.GetDecimal(6), 2);


                    lista.Add(aux);
                }
                conexion.Close();
                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
        public List<Articulos> listarConSP()
        {
            List<Articulos> lista = new List<Articulos>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                //string consulta = "Select A.Codigo, A.Nombre, A.Descripcion, A.ImagenUrl, M.Descripcion as Marca, C. Descripcion as Categoria, A. Precio, A.IdMarca, A.IdCategoria, A.Id From ARTICULOS A, MARCAS M, CATEGORIAS C where M.Id = A.IdMarca and C. Id = A. IdCategoria";
                //datos.setearConsulta(consulta);
                datos.setearProcedimiento("storedListar");

                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Articulos aux = new Articulos();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Codigo = (string)datos.Lector["Codigo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];

                    if (!(datos.Lector["ImagenUrl"] is DBNull))
                        aux.ImagenUrl = (string)datos.Lector["ImagenUrl"];

                    aux.Marca = new Marcas();
                    aux.Marca.Id = (int)datos.Lector["IdMarca"];
                    aux.Marca.Descripcion = (string)datos.Lector["Marca"];
                    aux.Categoria = new Categorias();
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Descripcion = (string)datos.Lector["Categoria"];
                    aux.Precio = Decimal.Round(datos.Lector.GetDecimal(6), 2);


                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void agregar(Articulos nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Insert into ARTICULOS (Codigo, Nombre, Descripcion, Precio, IdMarca, IdCategoria, ImagenUrl)Values('" + nuevo.Codigo + "', '" + nuevo.Nombre + "', '" + nuevo.Descripcion + "', " + nuevo.Precio + ", @idMarca, @idCategoria, @imagenUrl)");
                datos.setearParametro("@idMarca", nuevo.Marca.Id);
                datos.setearParametro("@idCategoria", nuevo.Categoria.Id);
                datos.setearParametro("@imagenUrl", nuevo.ImagenUrl);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void agregarConSP(Articulos nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("storedAltaArticulos");
                datos.setearParametro("@codigo", nuevo.Codigo);
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@descripcion", nuevo.Descripcion);
                datos.setearParametro("@idMarca", nuevo.Marca.Id);
                datos.setearParametro("@idCategoria", nuevo.Categoria.Id);
                datos.setearParametro("@imagenUrl", nuevo.ImagenUrl);
                datos.setearParametro("@precio", nuevo.Precio);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void modificar(Articulos articulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("update articulos set Codigo = @codigo, Nombre = @nombre, Descripcion = @descripcion, IdMarca = @idMarca, IdCategoria = @idCategoria, ImagenUrl = @imagenUrl, Precio = @precio where id = @id");
                datos.setearParametro("@codigo", articulo.Codigo);
                datos.setearParametro("@nombre", articulo.Nombre);
                datos.setearParametro("@descripcion", articulo.Descripcion);
                datos.setearParametro("@idMarca", articulo.Marca.Id);
                datos.setearParametro("@idCategoria", articulo.Categoria.Id);
                datos.setearParametro("@imagenUrl", articulo.ImagenUrl);
                datos.setearParametro("@precio", articulo.Precio);
                datos.setearParametro("@id", articulo.Id);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<Articulos> filtrar(string campo, string criterio, string filtro)
        {
            List<Articulos> lista = new List<Articulos>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "Select A.Codigo, A.Nombre, A.Descripcion, A.ImagenUrl, M.Descripcion as Marca, C. Descripcion as Categoria, A. Precio, A.IdMarca, A.IdCategoria, A.Id From ARTICULOS A, MARCAS M, CATEGORIAS C where M.Id = A.IdMarca and C. Id = A. IdCategoria And ";

                if (campo == "Precio")
                {
                    switch (criterio)
                    {
                        case "Mayor a":
                            consulta += "A.Precio > " + filtro;
                            break;
                        case "Menor a":
                            consulta += "A.Precio < " + filtro;
                            break;
                        default:
                            consulta += "A.Precio = " + filtro;
                            break;
                    }
                }
                else if (campo == "Nombre")
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += "Nombre Like '" + filtro + "%'";
                            break;
                        case "Termina con":
                            consulta += "Nombre Like '%" + filtro + "'";
                            break;
                        default:
                            consulta += "Nombre Like '%" + filtro + "%'";
                            break;
                    }
                }
                else if (campo == "Código")
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += "Codigo like '" + filtro + "%'";
                            break;
                        case "Termina con":
                            consulta += "Codigo like '%" + filtro + "'";
                            break;
                        default:
                            consulta += "Codigo like '%" + filtro + "%'";
                            break;
                    }
                }
                else if (campo == "Categoría")
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += "C.Descripcion like '" + filtro + "%'";
                            break;
                        case "Termina con":
                            consulta += "C.Descripcion like '%" + filtro + "'";
                            break;
                        default:
                            consulta += "C.Descripcion like '%" + filtro + "%'";
                            break;
                    }
                }
                else
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += "M.Descripcion Like '" + filtro + "%'";
                            break;
                        case "Termina con":
                            consulta += "M.Descripcion Like '%" + filtro + "'";
                            break;
                        default:
                            consulta += "M.Descripcion Like '%" + filtro + "%'";
                            break;
                    }
                }
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Articulos aux = new Articulos();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Codigo = (string)datos.Lector["Codigo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];

                    if (!(datos.Lector["ImagenUrl"] is DBNull))
                        aux.ImagenUrl = (string)datos.Lector["ImagenUrl"];

                    aux.Marca = new Marcas();
                    aux.Marca.Id = (int)datos.Lector["IdMarca"];
                    aux.Marca.Descripcion = (string)datos.Lector["Marca"];
                    aux.Categoria = new Categorias();
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Descripcion = (string)datos.Lector["Categoria"];
                    aux.Precio = Decimal.Round(datos.Lector.GetDecimal(6), 2);


                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void eliminar(int id)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();
                datos.setearConsulta("delete from articulos where id = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void modificarConSP(Articulos articulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                //datos.setearConsulta("update articulos set Codigo = @codigo, Nombre = @nombre, Descripcion = @descripcion, IdMarca = @idMarca, IdCategoria = @idCategoria, ImagenUrl = @imagenUrl, Precio = @precio where id = @id");
                datos.setearProcedimiento("storedModificarArticulos");
                datos.setearParametro("@codigo", articulo.Codigo);
                datos.setearParametro("@nombre", articulo.Nombre);
                datos.setearParametro("@descripcion", articulo.Descripcion);
                datos.setearParametro("@idMarca", articulo.Marca.Id);
                datos.setearParametro("@idCategoria", articulo.Categoria.Id);
                datos.setearParametro("@imagenUrl", articulo.ImagenUrl);
                datos.setearParametro("@precio", articulo.Precio);
                datos.setearParametro("@id", articulo.Id);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public List<Articulos> listarArticuloConID(List<int> listaArtId)
        {
            List<Articulos> lista = new List<Articulos>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = "Select A.Id, Codigo, Nombre, A.Descripcion, M.Descripcion Marca, C.Descripcion Categoria, A.IdMarca, A.IdCategoria, ImagenUrl, Precio from ARTICULOS A, MARCAS M, CATEGORIAS C where A.IdMarca = M.Id and A.IdCategoria = C.Id and A.Id IN (" + string.Join(",", listaArtId) + ")";
                datos.setearConsulta(consulta);

                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Articulos aux = new Articulos();
                    aux.Id = (int)datos.Lector["id"];
                    aux.Codigo = (string)datos.Lector["Codigo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    if (!(datos.Lector["Descripcion"] is DBNull))
                    {
                        aux.Descripcion = (string)datos.Lector["Descripcion"];
                    }
                    aux.Marca = new Marcas();
                    aux.Marca.Id = (int)datos.Lector["idMarca"];
                    aux.Marca.Descripcion = (string)datos.Lector["Marca"];

                    aux.Categoria = new Categorias();
                    aux.Categoria.Id = (int)datos.Lector["idCategoria"];
                    aux.Categoria.Descripcion = (string)datos.Lector["Categoria"];

                    if (!(datos.Lector["ImagenUrl"] is DBNull))
                        aux.ImagenUrl = (string)datos.Lector["ImagenUrl"];
                    aux.Precio = (decimal)datos.Lector["Precio"];

                    lista.Add(aux);

                }

                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}


