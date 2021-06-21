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
using Microsoft.Owin;

namespace ST.API.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [Authorize(Roles = "NormalUser, Admin")]
    public class SaleDetailsController : ApiController
    {
        private ISaleBusinessService _SaleBusinessService = null;
        public SaleDetailsController(ISaleBusinessService SaleBusinessService)
        {
            this._SaleBusinessService = SaleBusinessService;
        }
        // GET: api/SaleDetails
        public string Get()
        {
            return "test";
        }

        // GET: api/SaleDetails/5
        public HttpResponseMessage Get(int saleId, bool fullList, int createdBy)
        {
            SaleDetailsVM ObjSaleDetailsVM = new SaleDetailsVM();
            ObjSaleDetailsVM.SaleId = saleId;
            ObjSaleDetailsVM.CreatedBy = fullList ? 0 : createdBy;

            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _SaleBusinessService.GetSaleList(ObjSaleDetailsVM));
            return response;
        }

        // POST: api/SaleDetails
        public HttpResponseMessage Post(SaleDetailsVM ObjSaleDetailsVM)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            if (ObjSaleDetailsVM.SaleId == 0)
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _SaleBusinessService.AddNewShareSale(ObjSaleDetailsVM));
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _SaleBusinessService.UpdateShareSale(ObjSaleDetailsVM));
            }
            return response;
        }

        // PUT: api/SaleDetails/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/SaleDetails/5
        public HttpResponseMessage Delete(int SaleId, int deletedBy)
        {
            SaleDetailsVM ObjSaleDetailsVM = new SaleDetailsVM();
            ObjSaleDetailsVM.SaleId = SaleId;
            ObjSaleDetailsVM.UpdatedBy = deletedBy;

            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _SaleBusinessService.DeleteShareSale(ObjSaleDetailsVM));
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
