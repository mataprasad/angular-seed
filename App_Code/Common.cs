using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net.Mime;
using System.Security.Cryptography;
using System.Text;
using System.Web;

public static class Common
{
    public const String APPLICATION_NAME = @"Superb Accounts";

    public static readonly String SENDGRID_USERNAME = System.Configuration.ConfigurationManager.AppSettings["SENDGRID_USERNAME"];

    public static readonly String SENDGRID_PASSWORD = System.Configuration.ConfigurationManager.AppSettings["SENDGRID_PASSWORD"];

    public static readonly String SENDGRID_HOST = System.Configuration.ConfigurationManager.AppSettings["SENDGRID_HOST"];

    public static readonly String SENDGRID_PORT = System.Configuration.ConfigurationManager.AppSettings["SENDGRID_PORT"];

    public static string CreateMD5Hash(String input)
    {
        byte[] hash = null;
        try
        {
            var bytes = new ASCIIEncoding().GetBytes(input);
            var objMD5 = new MD5CryptoServiceProvider();
            hash = objMD5.ComputeHash(bytes);
            objMD5 = null;
        }
        catch { }
        return BytesToHexString(hash);
    }

    private static String BytesToHexString(byte[] input_bytes)
    {
        String s = null;
        try
        {
            var builder = new StringBuilder();
            for (int i = 0; i < input_bytes.Length; i++)
            {
                builder.AppendFormat("{0:x2}", input_bytes[i]);
            }
            s = builder.ToString();
            builder = null;
        }
        catch { }
        return s;
    }

    public static bool SendEmail(String subject, String body, List<String> toAddresses, String fromName = "DROID-APP", String fromEmail = "admin@droidapp.com")
    {
        try
        {
            MailMessage mailMsg = new MailMessage();

            foreach (var to in toAddresses)
            {
                // To
                mailMsg.To.Add(new MailAddress(to));
            }
            

            // From
            mailMsg.From = new MailAddress(fromEmail, fromName);

            // Subject and multipart/alternative Body
            mailMsg.Subject = subject;

            mailMsg.AlternateViews.Add(AlternateView.CreateAlternateViewFromString(body, null, MediaTypeNames.Text.Html));

            // Init SmtpClient and send
            SmtpClient smtpClient = new SmtpClient(SENDGRID_HOST, Convert.ToInt32(SENDGRID_PORT));
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(SENDGRID_USERNAME, SENDGRID_PASSWORD);
            smtpClient.Credentials = credentials;

            smtpClient.Send(mailMsg);
            return true;
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            return false;
        }
    }
}