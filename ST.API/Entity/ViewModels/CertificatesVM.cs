using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.ViewModels
{
    public class CertificatesVM
    {
        public int CertificateId { get; set; }
        public int UserId { get; set; }
        public string Path { get; set; }
        public DateTime UploadedDt { get; set; }
        public string UserFullName { get; set; }

    }
}
