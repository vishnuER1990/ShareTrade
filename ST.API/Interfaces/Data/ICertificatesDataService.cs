using Entity.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interfaces.Data
{
    public interface ICertificatesDataService
    {
        List<CertificatesVM> GetCertificates(int userId);

        Response UploadCertificates(int userId, string file);
    }
}
