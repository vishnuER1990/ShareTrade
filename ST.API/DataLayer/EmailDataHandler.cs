using Entity;
using System;
using System.Collections.Generic;
using System.Net.Mail;

using MimeKit;
using MailKit.Security;
using MailKit.Net.Smtp;
using System.Web;

namespace DataLayer
{
    public class EmailDataHandler
    {
        private string fromAddress { get; set; }
        private string toAddress { get; set; }
        private string subject { get; set; }
        private string body { get; set; }
        private bool copyToAdmin { get; set; }
        public HttpContext Context { get; set; }

        public EmailDataHandler(string fromAddress, string toAddress, string subject, string body, HttpContext Context, bool copyToAdmin = true)
        {
            this.fromAddress = fromAddress;
            this.toAddress = toAddress;
            this.subject = subject;
            this.body = body;
            this.copyToAdmin = copyToAdmin;
            this.Context = Context;
        }
        public void sendEmail()
        {
            try
            {
                HttpContext.Current = this.Context;

                if (HttpContext.Current.Request.Url.ToString().Contains("localhost"))
                {

                    var mailMessage = new MimeMessage();
                    mailMessage.From.Add(new MailboxAddress("S'Hail Bid Management System", this.fromAddress));
                    mailMessage.To.Add(new MailboxAddress("", this.toAddress));
                    if (copyToAdmin)
                    {
                        mailMessage.Bcc.Add(new MailboxAddress("", "itsupport@shailship.com"));
                    }
                    mailMessage.Subject = this.subject;
                    mailMessage.Body = new TextPart("html")
                    {
                        Text = this.body
                    };

                    using (var smtpClient = new MailKit.Net.Smtp.SmtpClient())
                    {
                        smtpClient.Connect("smtp.gmail.com", 587, SecureSocketOptions.Auto);
                        smtpClient.Authenticate("", "");
                        smtpClient.Send(mailMessage);
                        smtpClient.Disconnect(true);
                    }

                }
                else
                {

                    MailMessage message = new MailMessage();
                    message.From = new MailAddress("shailship@shailshiptrade.com");
                    message.To.Add(new MailAddress(this.toAddress));
                    if (copyToAdmin)
                    {
                        message.Bcc.Add(new MailAddress("itsupport@shailship.com"));
                    }
                    message.Body = this.body;
                    message.Subject = this.subject;
                    message.IsBodyHtml = true;

                    System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient();
                    client.Host = "relay-hosting.secureserver.net";
                    client.Port = 25;
                    client.Send(message);
                }

            }
            catch (Exception ex)
            {
                ErrorHandler.AddError(ex, 0);
               
            }
        }
    }

}
