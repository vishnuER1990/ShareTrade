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
    public class CredentialController : ApiController
    {
        private IUserBusinessService _UserBusinessService = null;
        public CredentialController(IUserBusinessService UserBusinessService)
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
            response = Request.CreateResponse(HttpStatusCode.OK, _UserBusinessService.ValidateUser(objUserVM));
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

        private int GetUserid()
        {
            var identity = (ClaimsIdentity)User.Identity;
            int loggedUserId = Convert.ToInt32(identity.Claims.Where(c => c.Type == ClaimTypes.Sid).Select(c => c.Value).FirstOrDefault());
            return loggedUserId;

        }
    }
}
