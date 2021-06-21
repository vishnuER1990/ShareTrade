using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;


namespace BusinessLayer
{
    public class CertificateBusinessHandler : ICertificateBusinessService
    {
        private ICertificatesDataService _CertificateDataService = null;
        public CertificateBusinessHandler(ICertificatesDataService certificatesDataService)
        {
            this._CertificateDataService = certificatesDataService;
        }
        public List<CertificatesVM> GetCertificates(int userId)
        {
            return _CertificateDataService.GetCertificates(userId);
        }

        public Response UploadCertificates(int userId, string file)
        {
            return _CertificateDataService.UploadCertificates(userId, file);
        }
    }
}
