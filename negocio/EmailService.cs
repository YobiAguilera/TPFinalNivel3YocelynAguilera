using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class EmailService
    {
        private MailMessage email;
        private SmtpClient server;
        public EmailService()
        {
            server = new SmtpClient();
            server.Credentials = new NetworkCredential("9e683e6ebf8fb5", "3f2a02f203237b");
            server.EnableSsl = true;
            server.Port = 2525;
            server.Host = "sandbox.smtp.mailtrap.io";
        }
        public void armarCorreo(string emailDestino, string asunto, string cuerpo)
        {
            email = new MailMessage();
            email.From = new MailAddress("noresponder@yobistore.com");
            email.To.Add(emailDestino);
            email.Subject = asunto;
            email.IsBodyHtml = true;
            //email.Body = "<h1>Reporte de registro</h1>"
            email.Body = cuerpo;
        }
        public void enviarEmail()
        {
            try
            {
                server.Send(email);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
