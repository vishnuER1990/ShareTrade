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
    public class SignupController : ApiController
    {
        private IUserBusinessService _UserBusinessService = null;
        public SignupController(IUserBusinessService UserBusinessService)
        {
            this._UserBusinessService = UserBusinessService;
        }
        // GET: api/Credential
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Credential/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Credential
        public HttpResponseMessage Post(UserVM objUserVM)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _UserBusinessService.ForgotPassword(objUserVM));
            return response;
        }

        // PUT: api/Credential/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Credential/5
        public void Delete(int id)
        {
        }
    }
}
