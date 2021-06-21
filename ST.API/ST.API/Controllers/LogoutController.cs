using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;

namespace ST.API.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [Authorize(Roles = "NormalUser, Admin")]
    public class LogoutController : ApiController
    {
        // GET: api/Logout
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Logout/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Logout
        public void Post()
        {
            var AuthenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            AuthenticationManager.SignOut();
            HttpContext.Current.GetOwinContext().Authentication.SignOut();
        }

        // PUT: api/Logout/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Logout/5
        public void Delete(int id)
        {
        }
    }
}
