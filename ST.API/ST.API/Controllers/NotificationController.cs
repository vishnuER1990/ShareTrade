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
    public class NotificationController : ApiController
    {
        private ISaleBusinessService _SaleBusinessService = null;
        public NotificationController(ISaleBusinessService SaleBusinessService)
        {
            this._SaleBusinessService = SaleBusinessService;
        }
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public HttpResponseMessage Post(NotifyVM notify)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _SaleBusinessService.NotifyPurchaseInterest(notify.userId, notify.Share, notify.Price));
            return response;
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}