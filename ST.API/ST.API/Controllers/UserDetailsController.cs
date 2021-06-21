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

    
    public class UserDetailsController : ApiController
    {
        private IUserBusinessService _UserBusinessService = null;
        public UserDetailsController(IUserBusinessService UserBusinessService)
        {
            this._UserBusinessService = UserBusinessService;
        }
        // GET: api/UserDetails
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/UserDetails/5
        [Authorize(Roles = "NormalUser, Admin")]
        public HttpResponseMessage Get(int userId)
        {
            UserVM objUserVM = new UserVM();
            objUserVM.UserId = userId;
            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _UserBusinessService.GetUserList(objUserVM));
            return response;
        }

        // POST: api/UserDetails
        public HttpResponseMessage Post(UserVM objUserVM)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            if (objUserVM.UserId != 0)
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _UserBusinessService.UpdateUser(objUserVM));
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _UserBusinessService.AddUser(objUserVM));
            }
            return response;
        }

        // PUT: api/UserDetails/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/UserDetails/5
        public void Delete(int user)
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
