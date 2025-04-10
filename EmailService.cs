using MailKit.Security;
using MimeKit;
using NETCore.MailKit.Core;
using NETCore.MailKit.Infrastructure.Internal;
using System.Text;
using MailKit.Net.Smtp;

namespace backend
{
    public class EmailService : IEmailService
    {
        private readonly IConfiguration _config;

        public EmailService(IConfiguration config)
        {
            _config = config;
        }

        public void Send(string mailTo, string subject, string message, bool isHtml = false, SenderInfo sender = null)
        {
            var email = new MimeMessage();

            var fromAddress = sender?.SenderEmail ?? _config["Email:Sender"];
            var fromName = sender?.SenderName ?? "My App";

            email.From.Add(new MailboxAddress(fromName, fromAddress));
            email.To.Add(MailboxAddress.Parse(mailTo));
            email.Subject = subject;
            email.Body = isHtml
                ? new TextPart("html") { Text = message }
                : new TextPart("plain") { Text = message };

            using var smtp = new SmtpClient();
            smtp.Connect(_config["Email:Smtp"], 587, SecureSocketOptions.StartTls);
            smtp.Authenticate(fromAddress, _config["Email:Password"]);
            smtp.Send(email);
            smtp.Disconnect(true);
        }

        public void Send(string mailTo, string subject, string message, string[] attachments, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public void Send(string mailTo, string subject, string message, Encoding encoding, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public void Send(string mailTo, string subject, string message, string[] attachments, Encoding encoding, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public void Send(string mailTo, string mailCc, string mailBcc, string subject, string message, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public void Send(string mailTo, string mailCc, string mailBcc, string subject, string message, string[] attachments, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public void Send(string mailTo, string mailCc, string mailBcc, string subject, string message, Encoding encoding, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public void Send(string mailTo, string mailCc, string mailBcc, string subject, string message, Encoding encoding, string[] attachments, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string subject, string message, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string subject, string message, string[] attachments, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string subject, string message, Encoding encoding, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string subject, string message, string[] attachments, Encoding encoding, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string mailCc, string mailBcc, string subject, string message, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string mailCc, string mailBcc, string subject, string message, string[] attachments, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string mailCc, string mailBcc, string subject, string message, Encoding encoding, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }

        public Task SendAsync(string mailTo, string mailCc, string mailBcc, string subject, string message, string[] attachments, Encoding encoding, bool isHtml = false, SenderInfo sender = null)
        {
            throw new NotImplementedException();
        }
    }
}
