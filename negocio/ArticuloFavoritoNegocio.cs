using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class ArticuloFavoritoNegocio
    {
        public List<int> listarFavoritos(int idUser)
        {
            AccesoDatos datos = new AccesoDatos();
            List<int> lista = new List<int>();

            try
            {
                datos.setearProcedimiento("ListarFavoritos");
                datos.setearParametro("@idUser", idUser); 
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    int aux = (int)datos.Lector["IdArticulo"];
                    lista.Add(aux);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar favoritos: " + ex.Message, ex);
            }
            finally
            {
                if (datos.Lector != null)
                    datos.Lector.Close(); 
                datos.cerrarConexion(); 
            }

            return lista;
        }


        public void insertarFavorito(ArticuloFavorito nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("InsertarFavorito");
                datos.setearParametro("@idUser", nuevo.IdUser);
                datos.setearParametro("@idArticulo", nuevo.IdArticulo);

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


        public void eliminarFavorito(int idArticulo, int idUser)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("EliminarFavoritoPorArticuloYUsuario");
                datos.setearParametro("@idArticulo", idArticulo);
                datos.setearParametro("@idUser", idUser);
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


        public void eliminarFavorito(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("EliminarFavoritoPorArticulo");
                datos.setearParametro("@idArticulo", id);
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
    }
}