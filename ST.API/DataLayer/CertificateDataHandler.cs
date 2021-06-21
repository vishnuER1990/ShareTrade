using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;
using System.IO;

namespace DataLayer
{
    public class CertificateDataHandler : ICertificatesDataService
    {
        public List<CertificatesVM> GetCertificates(int userId)
        {
            List<CertificatesVM> list = new List<CertificatesVM>();

            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    var certList = dbContext.Get_Certificates(userId);
                    list = certList.Select(x => new CertificatesVM
                    { 
                        UploadedDt = Convert.ToDateTime(x.UploadedDt),
                        UserFullName = x.Full_Name,                        
                        CertificateId = x.CertificateId,
                        Path = Path.GetFileName(x.Path),
                        UserId = Convert.ToInt32(x.UserId)                        
                    }).ToList();
                }
                catch (Exception ex)
                {
                    list = null;
                }
                return list;
            }
        }

        public Response UploadCertificates(int userId, string file)
        {
            Response objResponse = new Response();
            using (var dbContext = new ShareTradeEntities())
            {
                try
                {
                    Certificates certificates = new Certificates();
                    certificates.UserId = userId;
                    certificates.Path = file;
                    certificates.UploadedDt = DateTime.Now;
                    dbContext.Certificates.Add(certificates);
                    dbContext.SaveChanges();

                    objResponse.status = true;
                    objResponse.exception = string.Empty;
                }
                catch (Exception ex)
                {
                    objResponse.status = true;
                    objResponse.exception = Convert.ToString(ex);
                }
            }
            return objResponse;
        }
    }
}
