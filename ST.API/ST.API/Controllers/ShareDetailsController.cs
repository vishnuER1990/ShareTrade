using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Interfaces.Business;
using Entity.ViewModels;
using System.Web.Http.Cors;
using System.Security.Claims;

namespace ST.API.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [Authorize(Roles = "NormalUser, Admin")]
    public class ShareDetailsController : ApiController
    {
        
        private IShareDetailBusinessService _ShareBusinessService = null;
        public ShareDetailsController(IShareDetailBusinessService ShareBusinessService)
        {
            this._ShareBusinessService = ShareBusinessService;
        }
        // GET: api/ShareDetails
        public string Get()
        {
            return "test";
        }

        // GET: api/ShareDetails/5
        public HttpResponseMessage Get(int shareDetailsId, int CreatedBy)
        {
            ShareDetailsVM ObjShareDetailsVM = new ShareDetailsVM();
            ObjShareDetailsVM.ShareDetailsId = shareDetailsId;
            ObjShareDetailsVM.CreatedBy = CreatedBy;

            HttpResponseMessage response = new HttpResponseMessage();
            if (shareDetailsId == 0)
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _ShareBusinessService.GetShareList(ObjShareDetailsVM));
            }
            else
            {

                response = Request.CreateResponse(HttpStatusCode.OK, _ShareBusinessService.GetShareList(ObjShareDetailsVM).FirstOrDefault());
            }
            return response;
        }

        // POST: api/ShareDetails
        public HttpResponseMessage Post(ShareDetailsVM ObjShareDetailsVM)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            if (ObjShareDetailsVM.ShareDetailsId == 0)
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _ShareBusinessService.AddNewShare(ObjShareDetailsVM));
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _ShareBusinessService.UpdateShare(ObjShareDetailsVM));
            }
            return response;
        }

        // PUT: api/ShareDetails/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/ShareDetails/5
        public HttpResponseMessage Delete(int shareDetailsId, int deletedBy)
        {
            ShareDetailsVM ObjShareDetailsVM = new ShareDetailsVM();
            ObjShareDetailsVM.ShareDetailsId = shareDetailsId;
            ObjShareDetailsVM.UpdatedBy = deletedBy;
            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _ShareBusinessService.DeleteShare(ObjShareDetailsVM));
            return response;
        }
        private int GetUserid()
        {
            var identity = (ClaimsIdentity)User.Identity;
            int loggedUserId = Convert.ToInt32(identity.Claims.Where(c => c.Type == ClaimTypes.Sid).Select(c => c.Value).FirstOrDefault());
            return loggedUserId;

        }
    }
}
