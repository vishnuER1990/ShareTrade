using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using Interfaces.Business;
using Entity.ViewModels;


namespace ST.API.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class QIDController : ApiController
    {
        private IQIDBusinessService _QIDBusinessService = null;
        public QIDController(IQIDBusinessService QIDBusinessService)
        {
            this._QIDBusinessService = QIDBusinessService;
        }
        // GET: api/QID
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/QID/5
        public HttpResponseMessage Get(int qid, bool validateQid)
        {
            QIDDetailsVM objQIDDetailsVM = new QIDDetailsVM();
            objQIDDetailsVM.QID = qid;
            HttpResponseMessage response = new HttpResponseMessage();
            if (validateQid)
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _QIDBusinessService.ValidateQIDDetails(objQIDDetailsVM));
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _QIDBusinessService.GetQIDDetailsList(objQIDDetailsVM));
            }
            return response;
        }

        // POST: api/QID
        public void Post(QIDDetailsVM objQIDDetailsVM)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _QIDBusinessService.AddQIDDetails(objQIDDetailsVM));
        }

        // PUT: api/QID/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/QID/5
        public void Delete(int id)
        {
        }
    }
}
