using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;


namespace BusinessLayer
{
    public class ProposalBusinessHandler : IProposalBusinessService
    {
        private IProposalDataService _ProposalDataService = null;
        public ProposalBusinessHandler(IProposalDataService proposalDataService)
        {
            this._ProposalDataService = proposalDataService;
        }
        public Response AddProposal(ProposalDetailsVM ObjProposalDetailsVM)
        {
            return _ProposalDataService.AddProposal(ObjProposalDetailsVM);
        }

        public Response DeleteProposal(ProposalDetailsVM ObjProposalDetailsVM)
        {
            return _ProposalDataService.DeleteProposal(ObjProposalDetailsVM);
        }

        public List<ProposalDetailsVM> GetProposalList(ProposalDetailsVM ObjProposalDetailsVM)
        {

            return _ProposalDataService.GetProposalList(ObjProposalDetailsVM);
        }

        public Response UpdateProposal(ProposalDetailsVM ObjProposalDetailsVM)
        {
            return _ProposalDataService.UpdateProposal(ObjProposalDetailsVM);
        }
    }
}
