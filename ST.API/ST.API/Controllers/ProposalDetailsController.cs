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
    public class ProposalDetailsController : ApiController
    {
        private IProposalBusinessService _ProposalBusinessService = null;
        public ProposalDetailsController(IProposalBusinessService proposalBusinessService)
        {
            this._ProposalBusinessService = proposalBusinessService;
        }
        // GET: api/ProposalDetails
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/ProposalDetails/5
        public HttpResponseMessage Get(int saleId, int proposalId, int createdBy)
        {
            ProposalDetailsVM ObjProposalDetailsVM = new ProposalDetailsVM();
            ObjProposalDetailsVM.SaleId = saleId;
            ObjProposalDetailsVM.ProposalId = proposalId;
            ObjProposalDetailsVM.CreatedBy = createdBy;

            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _ProposalBusinessService.GetProposalList(ObjProposalDetailsVM));
            return response;
        }

        // POST: api/ProposalDetails
        public HttpResponseMessage Post(ProposalDetailsVM ObjProposalDetailsVM)
        {
            HttpResponseMessage response = new HttpResponseMessage();
            if(ObjProposalDetailsVM.ProposalId == 0)
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _ProposalBusinessService.AddProposal(ObjProposalDetailsVM));
            }
            else
            {
                response = Request.CreateResponse(HttpStatusCode.OK, _ProposalBusinessService.UpdateProposal(ObjProposalDetailsVM));
            }
            return response;
        }

        // PUT: api/ProposalDetails/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/ProposalDetails/5
        public HttpResponseMessage Delete(int proposalId, int deletedBy)
        {
            ProposalDetailsVM ObjProposalDetailsVM = new ProposalDetailsVM();
            ObjProposalDetailsVM.ProposalId = proposalId;
            ObjProposalDetailsVM.UpdatedBy = deletedBy;

            HttpResponseMessage response = new HttpResponseMessage();
            response = Request.CreateResponse(HttpStatusCode.OK, _ProposalBusinessService.DeleteProposal(ObjProposalDetailsVM));
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
