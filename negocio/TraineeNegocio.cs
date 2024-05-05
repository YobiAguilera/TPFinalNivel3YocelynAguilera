using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class TraineeNegocio
    {
        public void actualizar(Trainee user)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Update USERS set urlImagenPerfil = @imagen, Nombre = @nombre, Apellido = @apellido, FechaNacimiento = @fechaNacimiento Where Id = @id");
                //datos.setearParametro("@imagen", user.UrlImagenPerfil != null ? user.UrlImagenPerfil : "");
                datos.setearParametro("@fechaNacimiento", user.FechaNacimiento != null ? (object)user.FechaNacimiento : DBNull.Value);
                datos.setearParametro("@imagen", (object)user.UrlImagenPerfil ?? DBNull.Value);
                datos.setearParametro("@nombre", user.Nombre);
                datos.setearParametro("@apellido", user.Apellido);
                datos.setearParametro("@id", user.Id);
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

        public int insertarNuevo(Trainee nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("insertarNuevo");
                datos.setearParametro("@email", nuevo.Email);
                datos.setearParametro("@pass", nuevo.Pass);
                return datos.ejecutarAccionScalar();
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
        public bool Login(Trainee trainee)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Select id, email, pass, admin, urlImagenPerfil, nombre, apellido, fechaNacimiento from USERS Where email = @email And pass = @pass");
                datos.setearParametro("@email", trainee.Email);
                datos.setearParametro("@pass", trainee.Pass);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    trainee.Id = (int)datos.Lector["id"];
                    trainee.Admin = (bool)datos.Lector["admin"];
                    if (!(datos.Lector["nombre"] is DBNull))
                        trainee.Nombre = (string)datos.Lector["nombre"];
                    if (!(datos.Lector["apellido"] is DBNull))
                        trainee.Apellido = (string)datos.Lector["apellido"];
                    if (!(datos.Lector["fechaNacimiento"] is DBNull))
                        trainee.FechaNacimiento = (DateTime)datos.Lector["fechaNacimiento"];
                    if (!(datos.Lector["urlImagenPerfil"] is DBNull))
                        trainee.UrlImagenPerfil = (string)datos.Lector["urlImagenPerfil"];

                    return true;
                }
                return false;
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
