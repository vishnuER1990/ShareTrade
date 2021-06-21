using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using Interfaces.Business;
using Entity.ViewModels;
using System.Security.Claims;
using System.Web;

namespace ST.API.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [Authorize(Roles = "NormalUser, Admin")]
    public class ManageCertificatesController : ApiController
    {
        private ICertificateBusinessService _CertificateBusinessService = null;
        public ManageCertificatesController(ICertificateBusinessService certificateBusinessService)
        {
            this._CertificateBusinessService = certificateBusinessService;
        }

        // GET: api/ManageCertificates
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/ManageCertificates/5
        public HttpResponseMessage Get(int userId)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _CertificateBusinessService.GetCertificates(userId));
            return response;
        }

        // POST: api/ManageCertificates
        public HttpResponseMessage Post()
        {
            
            HttpResponseMessage response = new HttpResponseMessage();
            var httpRequest = HttpContext.Current.Request;
            if (httpRequest.Files.Count > 0)
            {
                foreach (string file in httpRequest.Files)
                {
                    var postedFile = httpRequest.Files[file];
                    var filePath = HttpContext.Current.Server.MapPath("~/UploadFile/" + postedFile.FileName);
                    postedFile.SaveAs(filePath);
                    response = Request.CreateResponse(HttpStatusCode.OK, _CertificateBusinessService.UploadCertificates(Convert.ToInt32(httpRequest.Params["userId"]), Convert.ToString(filePath)));
                }
            }

            return response;
        }
    

    // PUT: api/ManageCertificates/5
    public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/ManageCertificates/5
        public void Delete(int id)
        {
        }
    }
}
