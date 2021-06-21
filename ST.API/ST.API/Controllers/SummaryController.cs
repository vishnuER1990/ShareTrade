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

namespace ST.API.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [Authorize(Roles = "NormalUser, Admin")]
    public class SummaryController : ApiController
    {
        private ISummaryBusinessService _SummaryBusinessService = null;
        public SummaryController(ISummaryBusinessService summaryBusinessService)
        {
            this._SummaryBusinessService = summaryBusinessService;
        }

        // GET: api/Summary    
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Summary/5
        public HttpResponseMessage Get(int userId, bool bidSubmitted, bool bidReceived, bool notifications)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            if (bidReceived)
            {

                response = Request.CreateResponse(HttpStatusCode.OK, _SummaryBusinessService.GetBidsReceived(userId));
            }
            else if(bidSubmitted)
            {

                response = Request.CreateResponse(HttpStatusCode.OK, _SummaryBusinessService.GetBidsSubmitted(userId));
            }
            else if (notifications)
            {

                response = Request.CreateResponse(HttpStatusCode.OK, _SummaryBusinessService.GetNotifications(userId));
            }
            else
                response = Request.CreateResponse(HttpStatusCode.OK, _SummaryBusinessService.GetSummary(userId));

            return response;
        }

        // POST: api/Summary
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Summary/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Summary/5
        public void Delete(int id)
        {
        }
    }
}
