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
    public class ReportController : ApiController
    {
        private IReportBusinessService _ReportBusinessService = null;
        public ReportController(IReportBusinessService ReportBusinessService)
        {
            this._ReportBusinessService = ReportBusinessService;
        }

        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "Empty" };
        }

        // GET api/<controller>/5
        public HttpResponseMessage Get(int reportId, string fromDate, string toDate)
        {
            HttpResponseMessage response = new HttpResponseMessage();

            if (reportId == 1)
                response = Request.CreateResponse(HttpStatusCode.OK, _ReportBusinessService.GetRegistredUser(Convert.ToDateTime(fromDate) , Convert.ToDateTime(toDate)));
            else if (reportId == 2)
                response = Request.CreateResponse(HttpStatusCode.OK, _ReportBusinessService.GetSaleList(Convert.ToDateTime(fromDate), Convert.ToDateTime(toDate)));
            else if (reportId == 3)
                response = Request.CreateResponse(HttpStatusCode.OK, _ReportBusinessService.GetProxy(Convert.ToDateTime(fromDate), Convert.ToDateTime(toDate)));
            else
                response = Request.CreateResponse(HttpStatusCode.OK, _ReportBusinessService.GetPurchaseList(Convert.ToDateTime(fromDate), Convert.ToDateTime(toDate)));
            return response;
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
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